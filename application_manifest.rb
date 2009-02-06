require './lib/rails_manifest.rb'

# This class is for a *single* application.
class ApplicationManifest < RailsManifest
  
  # name your app
  application = "birddog"
  
  recipe :passenger_site, :domain => "birddog.railsmachine.com"
  recipe :mysql_user, :password => "secret"
  
  # add your gems and other good stuff here
  def application_packages
    # package "some_awesome_gem", :ensure => :installed, :provider => :gem
    # package "some_awesome_native_package", :ensure => :installed
  end
end