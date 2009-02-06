module CapistranoRecipes
  def capistrano_setup(args)
    root_path = "#{RAILS_PREFIX}/#{args[:name]}"
    dirs = %w{shared, shared/config, shared/system, releases}
    dirs.each do |dir|
      path = "#{root_path}/#{dir}"
      file path, { :ensure => :directory, :owner => RAILS_USER, :group => RAILS_GROUP, :require => file(root_path) }
    end
  end
end