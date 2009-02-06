PASSENGER_VERSION = "2.0.6"

module PassengerRecipes

  def passenger
   package :passenger, :ensure => :installed, :provider => :gem

   # this needs to be attached to a fact
   #version = Gem::SourceIndex.from_installed_gems.find_name("passenger").last.version.to_s
   
   path = "/usr/lib/ruby/gems/1.8/gems/passenger-#{PASSENGER_VERSION}"

   exec :build_passenger, {:cwd => path, 
                             :command => '/usr/bin/ruby -S rake clean apache2', 
                             :creates => "#{path}/ext/apache2/mod_passenger.so" }

   load_content = <<-LOAD_CONTENT
     LoadModule passenger_module #{path}/ext/apache2/mod_passenger.so
   LOAD_CONTENT

   load_file = '/etc/apache2/mods-available/passenger.load'
   file load_file, {
         :ensure   => :present,
         :content => load_content }
     
   conf_content = <<-CONF_CONTENT
     PassengerRoot #{path}
     PassengerRuby /usr/bin/ruby
   CONF_CONTENT

   conf_file = '/etc/apache2/mods-available/passenger.conf'
   file conf_file, {
         :ensure   => :present,
         :content => conf_content }

   exec 'enable_passenger', { :command => '/usr/sbin/a2enmod passenger', 
                             :creates => '/etc/apache2/mods-enabled/passenger.load',
                             :require => [package("apache2-mpm-worker"), file(conf_file), file(load_file)}  
  end
end