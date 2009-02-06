module CapistranoRecipes
  def capistrano_setup
    root_path = "#{RAILS_PREFIX}/#{self.name}"
    
    file_args = { :ensure => :directory, :owner => RAILS_USER, :group => RAILS_GROUP, :require => file(root_path) }
    file "#{root_path}/shared", file_args
    file "#{root_path}/releases", file_args
    
    file_args[:require] = file("#{root_path}/shared")
    file "#{root_path}/shared/config", file_args
    file "#{root_path}/shared/system", file_args
  end
end