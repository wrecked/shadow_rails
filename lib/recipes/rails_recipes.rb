module RailsRecipes 
  def rails_gem
    package "rails", :ensure => :installed, :provider => :gem
  end
  
  def rails_user
    user RAILS_USER, :ensure => :present 
  end
  
  def rails_prefix
    file RAILS_PREFIX, { :ensure => :directory, :owner => RAILS_USER, :group => RAILS_PREFIX, :require => user(RAILS_USER) }
  end
  
  def rails_root(args)
    path = "#{RAILS_PREFIX}/#{args[:name]}"
    file path, { :ensure => :directory, :owner => RAILS_USER, :group => RAILS_GROUP, :require => user(RAILS_USER) }
  end
end