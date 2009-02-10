require 'shadow_puppet'
require File.dirname(__FILE__) + '/recipes.rb'

Configuration[:user] = "rails"
Configuration[:group] = Configuration[:user]

# if you change this, fix file resources in rails_recipes.rb
Configuration[:prefix] = "/u/apps"
Configuration[:passenger_version] = "2.0.6"

class RailsManifest < ShadowPuppet::Manifest
  include MySQLRecipes
  include PassengerRecipes
  include ApacheRecipes
  include RailsRecipes
  include CapistranoRecipes
  
  class << self
    def name(value)
      Configuration[:name] = value
    end
    
    def domain(value)
      Configuration[:domain] = value
    end
    
    def database_password(value)
      Configuration[:database_password] = value
    end
  end
  
  recipe :mysql_server, :mysql_gem
  recipe :apache_server
  recipe :passenger_gem, :passenger_apache_module
  recipe :rails_gem, :rails_prefix, :rails_root
  recipe :mysql_database
  recipe :application_packages
  recipe :passenger_site
  recipe :mysql_user
  recipe :capistrano_setup
  
  # implement this in subclass if you want
  def applications_packages
  end
  
end	