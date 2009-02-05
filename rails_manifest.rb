require 'shadow_puppet'
require 'lib/mysql.rb'
require 'lib/passenger.rb'

class RailsManifest < ShadowPuppet::Manifest
  
  include MySQL
  include Passenger
  
  recipe :mysql
  recipe :rails
  recipe :apache
  recipe :passenger
  
end	