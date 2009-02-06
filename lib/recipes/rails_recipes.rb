module RailsRecipes 
  def rails_gem
    package "rails", :ensure => :installed, :provider => :gem
  end
  
  def rails_user
    user "rails", :ensure => :present 
  end
  
  def rails_prefix
    file "/var/rails", { :ensure => :directory, :owner => "rails", :group => "rails", :require => user("rails") }
  end
end