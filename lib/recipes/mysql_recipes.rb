module MySQLRecipes
  
  def mysql_server
    package "mysql-server", :ensure => :installed
    service "mysql", :require => package("mysql-server")
  end
  
  def mysql_gem
    package "libmysqlclient15-dev", :ensure => :installed
    package "mysql", :ensure => :installed, :provider => :gem, :require => package("libmysqlclient15-dev")
  end
  
  def mysql_user
    
  end
  
  def mysql_database
    
  end
end