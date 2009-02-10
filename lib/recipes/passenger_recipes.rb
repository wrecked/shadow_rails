require File.join(File.dirname(__FILE__), 'configuration.rb')

module PassengerRecipes

  def passenger_gem
    package "passenger", :ensure => :installed, :provider => :gem
  end
   
  def passenger_apache_module 
    # this needs to be attached to a fact
    #version = Gem::SourceIndex.from_installed_gems.find_name("passenger").last.version.to_s
   
    path = "/usr/lib/ruby/gems/1.8/gems/passenger-#{Configuration[:passenger_version]}"
    
    # Install Apache2 developer library
    package "apache2-threaded-dev", :ensure => :installed
    
    # Build Passenger from source
    exec "build_passenger", {:cwd => path, 
                             :command => '/usr/bin/ruby -S rake clean apache2', 
                             :creates => "#{path}/ext/apache2/mod_passenger.so", 
                             :require => [package("passenger"), package("apache2-mpm-worker"), package("apache2-threaded-dev")] }

    # TODO: ShadowPuppet needs template helper
    load_file = '/etc/apache2/mods-available/passenger.load'
    load_template = File.join(File.dirname(__FILE__), "../../templates", "passenger.load.erb")
    load_template_contents = File.read(load_template)
    load_content = ERB.new(load_template_contents).result(binding)
    file load_file, { :ensure => :present, 
                      :content => load_content, 
                      :require => [exec("build_passenger")], 
                      :alias => "passenger_load" }

    # TODO: ShadowPuppet needs template helper
    conf_file = '/etc/apache2/mods-available/passenger.conf'
    conf_template = File.join(File.dirname(__FILE__), "../../templates", "passenger.conf.erb")
    conf_template_contents = File.read(conf_template)
    conf_content = ERB.new(conf_template_contents).result(binding)
    file conf_file, { :ensure => :present, 
                      :content => conf_content,
                      :require => [exec("build_passenger")], 
                      :alias => "passenger_conf" }

    exec "enable_passenger", { :command => '/usr/sbin/a2enmod passenger', 
                               :unless => 'ls /etc/apache2/mods-enabled/passenger.*',
                               :require => [exec("build_passenger"), file("passenger_conf"), file("passenger_load")]}  
  end
  
  def passenger_site(args)
    name = Configuration[:name]
    domain = Configuration[:domain]
    
    # TODO: ShadowPuppet needs template helper
    conf_file = "/etc/apache2/sites-available/#{name}"
    conf_template = File.join(File.dirname(__FILE__), "../../templates", "passenger.vhost.erb")
    conf_template_contents = File.read(conf_template)
    doc_root = Configuration[:prefix] + "/" + name + "/current/public"
    conf_content = ERB.new(conf_template_contents).result(binding)
    file conf_file, { :ensure => :present, :content => conf_content, :notify => service("apache2") }
    
    exec "passenger_enable_site", { :command => "/usr/sbin/a2ensite #{name}", 
                             :creates => '/etc/apache2/sites-enabled/#{name}',
                             :require => [package("apache2-mpm-worker"), file(conf_file)]}
  end
end