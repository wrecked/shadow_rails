require 'shadow_puppet'
require 'lib/mysql_recipes.rb'
require 'lib/passenger_recipes.rb'

class RailsManifest < ShadowPuppet::Manifest
  
  include MySQLRecipes
  include PassengerRecipes
  
  recipe :mysql
  recipe :rails
  recipe :apache
  recipe :passenger
  
end	