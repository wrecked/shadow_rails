module CapistranoRecipes
  def capistrano_setup(args)
    root_path = "#{RAILS_PREFIX}/#{args[:name]}"
    
    file "#{root_path}/shared", { :ensure => :directory, :owner => RAILS_USER, :group => RAILS_GROUP, :require => file(root_path) }
    file "#{root_path}/shared/config", { :ensure => :directory, :owner => RAILS_USER, :group => RAILS_GROUP, :require => file("#{root_path}/shared") }
    file "#{root_path}/shared/system", { :ensure => :directory, :owner => RAILS_USER, :group => RAILS_GROUP, :require => file("#{root_path}/shared") }
    file "#{root_path}/releases", { :ensure => :directory, :owner => RAILS_USER, :group => RAILS_GROUP, :require => file(root_path) }
  end
end