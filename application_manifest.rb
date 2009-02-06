require './lib/rails_manifest.rb'

# This class could handle configuration of several applications.
class ApplicationManifest < RailsManifest
  
  # name your app
  name = "birddog"
  domain = "birddog.railsmachine.com"
  
  recipe :rails_root, :name => name
  recipe :capistrano_setup, :name => name
  recipe :passenger_site, :name => name, :domain => domain
  recipe :application_packages
  
  # add your gems and other good stuff here
  def application_packages
    # package "some_awesome_gem", :ensure => :installed, :provider => :gem
    # package "some_awesome_native_package", :ensure => :installed
  end
end