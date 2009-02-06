require 'shadow_puppet'
require File.dirname(__FILE__) + '/recipes.rb'


class RailsManifest < ShadowPuppet::Manifest
  include MySQLRecipes
  include PassengerRecipes
  include ApacheRecipes
  include RailsRecipes
  
  recipe :mysql
  recipe :rails
  recipe :apache
  recipe :passenger
end	