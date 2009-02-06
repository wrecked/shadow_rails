require './lib/rails_manifest.rb'

class ApplicationManifest < RailsManifest
  
  name = "test"
  recipe :rails_root, :name => name
  recipe :capistrano_setup, :name => name
  
  recipe :application_packages
  
  # add your gems and other good stuff here
  def application_packages
    # package "some_awesome_gem", :ensure => :installed, :provider => :gem
    # package "some_awesome_native_package", :ensure => :installed
  end
end