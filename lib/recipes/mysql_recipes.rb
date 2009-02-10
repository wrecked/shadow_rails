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
    db_name = Configuration[:name] + "_production"
    db_user = Configuration[:name]
    db_password = Configuration[:database_password]
    sql = "GRANT ALL PRIVILEGES ON #{db_name}.* TO #{db_user}@localhost IDENTIFIED BY '#{db_password}';"

    # ok, this could compare the shown grants for the user to what it expects.
    exec "create_user", { :command => "/usr/bin/mysql -u root -e \"#{sql}\"",
                             :unless => "mysql -u root -p -e 'show grants for #{db_user}@localhost;'",
                             :require => [exec("create_database")]}
  end

  def mysql_database
    db_name = Configuration[:name] + "_production"
    exec "create_database", { :command => "/usr/bin/mysql -u root -e 'create database #{db_name};'",
                             :unless => "mysql -u root -p -e 'show create database #{db_name};'",
                             :require => [package("mysql-server")]}
  end
end