module CapistranoRecipes
  def capistrano_setup(args)
    rails_root = "#{RAILS_PREFIX}/#{args[:name]}"
    dirs = %w{shared, shaded/config, shared/system, releases}
    dirs.each do |dir|
      path = "#{rails_root}/#{dir}"
      file path, { :ensure => :directory, :owner => RAILS_USER, :group => RAILS_GROUP, :require => file(rails_root) }
    end
  end
end