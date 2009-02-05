require 'shadow_puppet'

class RailsManifest < ShadowPuppet::Manifest
  
  recipe :essential
  recipe :mysql
  recipe :rails
  recipe :git
  recipe :apache
  recipe :passenger
  
  def git
    package "git-core", :ensure => :installed
  end
  
  def apache
    package "apache2-mpm-worker", :ensure => :installed 
    package "apache2-threaded-dev", :ensure => :installed
    service :apache2, :require => package "apache2-mpm-worker"
  end
  
  def passenger
    package "passenger", :ensure => :installed, :provider => :gem
    
    version = Gem::SourceIndex.from_installed_gems.find_name("passenger").last.version.to_s
    path = "/usr/lib/ruby/gems/1.8/gems/passenger-#{version}"
    
    exec { :build-passenger, :cwd => path, 
                              :command => '/usr/bin/ruby1.8 -S rake clean apache2', 
                              :creates => "#{path}/ext/apache2/mod_passenger.so"}
    
    contents = <<-CONTENTS
      LoadModule passenger_module #{path}/ext/apache2/mod_passenger.so
    CONTENTS
    
    file '/etc/apache2/mods-available/passenger.load',
          :ensure   => :present,
          :contents => contents,
          :require  => [package(:passenger), exec(:build-passenger)]
          
    contents = <<-CONTENTS
      PassengerRoot #{path}
      PassengerRuby /usr/bin/ruby1.8
    CONTENTS
    
    file '/etc/apache2/mods-available/passenger.conf',
          :ensure   => :present,
          :contents => contents,
          :require  => [package(:passenger), exec(:build-passenger)]
    
    exec {'enable-passenger', :command => 'a2enmod passenger', 
                              :creates => '/etc/apache2/mods-enabled/passenger.load'}  
  end
  
  def essential
    package "build-essential", :ensure => :installed
    package "ruby-dev", :ensure => :installed
  end
  
  def mysql
    package "mysql-server", :ensure => :installed
    package "libmysqlclient15-dev", :ensure => :installed
    package "mysql", :ensure => :installed, :provider => :gem, :require => package("libmysqlclient15-dev")
    service :mysql, :require => package "mysql-server"
  end

  def rails
    package "rails", :ensure => :installed, :provider => :gem
  end
  
end	