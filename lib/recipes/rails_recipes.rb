require File.join(File.dirname(__FILE__), 'configuration.rb')

module RailsRecipes
  def rails_gem
    package "rails", { :ensure => :installed, :provider => :gem }
  end

  def rails_prefix
    file "/u", { :ensure => :directory, :owner => Configuration[:user], :group => Configuration[:group] }
    file "/u/apps", { :ensure => :directory, :owner => Configuration[:user], :group => Configuration[:group], :require => [file("/u")] }
  end

  def rails_root
    path = "#{Configuration[:prefix]}/#{Configuration[:name]}"
    file path, { :ensure => :directory, :owner => Configuration[:user], :group => Configuration[:group] }
  end
end