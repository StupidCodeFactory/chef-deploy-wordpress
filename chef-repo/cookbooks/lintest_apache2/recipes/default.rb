#
# Cookbook Name:: lintest_apache2
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'mysql-server'
package 'php5-mysql'
package 'php5-gd'

include_recipe 'apache2::default'
include_recipe 'apache2::mod_rewrite'
include_recipe 'apache2::mod_php5'

app = [node['lintest_wordpress']['vhost_dir'],  node['hostname']].join('/')
apache_docroot = "#{app}/public_html"


directory app do
  owner "root"
  group "root"
  mode 00755
  recursive true
end

directory apache_docroot do
  owner "root"
  group "root"
  mode 00755
  recursive true
end


wordpress app do
  mysql_password node['lintest_wordpress']['mysql_password']
  mysql_user     node['lintest_wordpress']['mysql_user']
  mysql_host     node['lintest_wordpress']['mysql_host']
  mysql_dbname   node['lintest_wordpress']['mysql_dbname']
  docroot apache_docroot
end

app_name = 'wordpress'
web_app app_name do
  server_name node['hostname']
  server_aliases [node['fqdn'], node['domain']]
  docroot apache_docroot
  error_log [node['apache']['log_dir'], "#{app_name}-error.log"].join('/')
  custom_log [node['apache']['log_dir'], "#{app_name}-custom.log"].join('/')
  rewrite_log [node['apache']['log_dir'], "#{app_name}-rewrite.log"].join('/')
end




