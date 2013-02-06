#
# Cookbook Name:: rad_voucher
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

service "apache2" do
  supports :restart => true
  # If restarted/reloaded too quickly httpd has a habit of failing.
  # This may happen with multiple recipes notifying apache to restart - like
  # during the initial bootstrap.
  restart_command "/etc/init.d/apache2 restart && sleep 2"
  reload_command "/etc/init.d/apache2 reload && sleep 2"
end

execute "htpasswd -c -b -s basic_access.admin admin #{node[:basic_access][:admin]}" do
  cwd "/etc/apache2/"
  user "root"
  group "root"
  notifies :restart, resources(:service => "apache2")
end