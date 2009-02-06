PASSENGER_VERSION = "2.0.6"

module PassengerRecipes

  def passenger_gem
    package "passenger", :ensure => :installed, :provider => :gem
  end
   
  def passenger_apache_module 
    # this needs to be attached to a fact
    #version = Gem::SourceIndex.from_installed_gems.find_name("passenger").last.version.to_s
   
    path = "/usr/lib/ruby/gems/1.8/gems/passenger-#{PASSENGER_VERSION}"

    exec "build_passenger", {:cwd => path, 
                             :command => '/usr/bin/ruby -S rake clean apache2', 
                             :creates => "#{path}/ext/apache2/mod_passenger.so", 
                             :require => package("passenger") }

    # TODO: ShadowPuppet needs template helper
    load_file = '/etc/apache2/mods-available/passenger.load'
    load_template = File.join(File.dirname(__FILE__), "../../templates", "passenger.load.erb")
    load_template_contents = File.read(load_template)
    load_content = ERB.new(load_template_contents).result(binding)
    file load_file, { :ensure => :present, :content => load_content }

    conf_file = '/etc/apache2/mods-available/passenger.conf'
    conf_template = File.join(File.dirname(__FILE__), "../../templates", "passenger.conf.erb")
    conf_template_contents = File.read(conf_template)
    conf_content = ERB.new(conf_template_contents).result(binding)
    file conf_file, { :ensure => :present, :content => conf_content }

    exec "enable_passenger", { :command => '/usr/sbin/a2enmod passenger', 
                             :creates => '/etc/apache2/mods-enabled/passenger.load',
                             :require => [package("apache2-mpm-worker"), file(conf_file), file(load_file)]}  
  end
  
  def passenger_vhost(args)
    name = args[:name]
    domain = args[:domain]
    
    
  end
end