require 'shadow_puppet'

class RailsManifest < ShadowPuppet::Manifest
  
  include MySQL
  include Passenger
  
  recipe :mysql
  recipe :rails
  recipe :apache
  recipe :passenger
  
end	