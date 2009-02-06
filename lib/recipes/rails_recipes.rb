module RailsRecipes
  def rails_gem
    package "rails", :ensure => :installed, :provider => :gem
  end
end