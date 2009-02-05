require 'rubygems'
require 'shadow_facter'

def installed_fact(n)
  name = n
  fact(name) { exec("#{name.to_s} --version") ? true : false }
end

def installed_gem_fact(n)
  gem_name = n.to_s
  fact_name = gem_name + "_gem"
  fact(fact_name.to_sym) { Gem.available? gem_name }
end 

namespace :installed do
  installed_fact :rails
  installed_fact :git
  installed_fact :mysql
  installed_fact :puppet
  installed_fact :gem
  installed_gem_fact :mysql
  installed_fact :gcc
  installed_gem_fact :shadow_puppet
end
