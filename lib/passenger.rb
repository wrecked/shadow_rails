PASSENGER_VERSION = "2.0.6"

module Passenger
  
  def apache
    package "apache2-mpm-worker", :ensure => :installed 
    package "apache2-threaded-dev", :ensure => :installed
    service :apache2, :require => package "apache2-mpm-worker"
  end

  def passenger
   package "passenger", :ensure => :installed, :provider => :gem

   # this needs to be attached to a fact
   #version = Gem::SourceIndex.from_installed_gems.find_name("passenger").last.version.to_s
   
   path = "/usr/lib/ruby/gems/1.8/gems/passenger-#{PASSENGER_VERSION}"

   exec { :build-passenger, :cwd => path, 
                             :command => '/usr/bin/ruby -S rake clean apache2', 
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
     PassengerRuby /usr/bin/ruby
   CONTENTS

   file '/etc/apache2/mods-available/passenger.conf',
         :ensure   => :present,
         :contents => contents,
         :require  => [package(:passenger), exec(:build-passenger)]

   exec {'enable-passenger', :command => 'a2enmod passenger', 
                             :creates => '/etc/apache2/mods-enabled/passenger.load'}  
 end


 def rails
   package "rails", :ensure => :installed, :provider => :gem
 end
end