module MySQLRecipes
  
  def mysql
    package "mysql-server", :ensure => :installed
    package "libmysqlclient15-dev", :ensure => :installed
    package "mysql", :ensure => :installed, :provider => :gem, :require => package("libmysqlclient15-dev")
    service :mysql, :require => package("mysql-server")
  end
  
end