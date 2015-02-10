#
# Cookbook Name:: webserver
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

package "httpd"

template "/var/www/html/index.html" do
  source "index.html.erb"
end

# template "/var/www/html/index.html" do
#   source "index_up.html.erb"
#   variables({
#     :machines => search(:node, 'tags:*-webserver')
#   })
# end


service "httpd" do
 action [ :enable, :start ]
end


service "iptables" do
  action [ :disable, :stop ]
end