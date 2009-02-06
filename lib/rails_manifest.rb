require 'shadow_puppet'
require File.dirname(__FILE__) + '/recipes.rb'

class RailsManifest < ShadowPuppet::Manifest
  include MySQLRecipes
  include PassengerRecipes
  include ApacheRecipes
  include RailsRecipes
  
  recipe :mysql_server, :mysql_gem
  recipe :apache_server
  recipe :passenger_gem, :passenger_apache_module
  recipe :rails_gem, :rails_user, :rails_prefix
end	