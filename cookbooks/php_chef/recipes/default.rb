#
# Cookbook Name:: php_chef
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "apache2"
include_recipe "mysql::client"
include_recipe "mysql::server"
include_recipe "php"
include_recipe "php::module_mysql"
include_recipe "apache2::mod_php5"
include_recipe "mysql::ruby"

apache_site "default" do
  enable true
end

mysql_connection_info = {
  :host => 'localhost',
  :username => 'root',
  :password => node['mysql']['server_root_password']
}

mysql_database node['php_chef']['database'] do
#  connection ({:host => 'localhost', :username => 'root', :password => node['mysql']['server_root_password']})
  connection mysql_connection_info 
  action :create
end

mysql_database_user node['php_chef']['db_username'] do
  #connection ({:host => 'localhost', :username => 'root', :password => node['mysql']['server_root_password']})
  connection mysql_connection_info 
  password node['php_chef']['db_password']
#  password "wrongpw"
  database_name node['php_chef']['database']
  privileges [:select, :update, :insert, :create, :delete]
  action :grant
end

mysql_database 'drop table' do
  connection mysql_connection_info
  database_name node['php_chef']['database']
  begin 
  sql 'DROP TABLE welcome_messages;'
  rescue
    nil
  end
  action :query
end

mysql_database 'create table' do
  connection mysql_connection_info
  database_name node['php_chef']['database']
  sql 'CREATE TABLE welcome_messages(message varchar(400) NOT NULL);'
  action :query
end

mysql_database 'add welcome message' do
  connection mysql_connection_info
  database_name node['php_chef']['database']
  sql 'INSERT INTO welcome_messages VALUE ("Heloo World");'
  action :query
end

template "/var/www/test.php" do
  source  "test.php.erb"
  action :create
end

