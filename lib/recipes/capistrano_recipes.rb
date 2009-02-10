require File.join(File.dirname(__FILE__), 'configuration.rb')

module CapistranoRecipes

  def capistrano_setup
    root_path = "#{Configuration[:prefix]}/#{Configuration[:name]}"

    file_args = { :ensure => :directory, :owner => Configuration[:user], :group => Configuration[:group], :require => file(root_path) }
    file "#{root_path}/shared", file_args
    file "#{root_path}/releases", file_args

    file_args[:require] = file("#{root_path}/shared")
    file "#{root_path}/shared/pids", file_args
    file "#{root_path}/shared/system", file_args
    file "#{root_path}/shared/log", file_args

  end
end