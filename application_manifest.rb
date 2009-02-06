require './lib/rails_manifest.rb'

class ApplicationManifest < RailsManifest
  
  name = "test"
  recipe :rails_root, :name => name
  recipe :capistrano_setup, :name => name
  
  # add your gems here and other good stuff
  
end