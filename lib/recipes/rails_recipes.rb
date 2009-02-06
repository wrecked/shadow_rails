require File.join(File.dirname(__FILE__), 'configuration.rb')

module RailsRecipes 
  def rails_gem
    package "rails", :ensure => :installed, :provider => :gem
  end
  
  def rails_user
    user Configuration[:user], :ensure => :present 
  end
  
  def rails_prefix
    file RAILS_PREFIX, { :ensure => :directory, :owner => Configuration[:user], :group => Configuration[:group], :require => user(Configuration[:user]) }
  end
  
  def rails_root
    path = "#{Configuration[:prefix]}/#{Configuration[:name]}"
    file path, { :ensure => :directory, :owner => Configuration[:user], :group => Configuration[:group], :require => user(Configuration[:user]) }
  end
end