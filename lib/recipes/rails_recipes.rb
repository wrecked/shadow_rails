module RailsRecipes
  def rails
    package "rails", :ensure => :installed, :provider => :gem
  end
end