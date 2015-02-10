#
# Cookbook Name:: metal
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require "chef/provisioning/aws_driver"
with_driver "aws"

name = "alexv"

# declare security groups
aws_security_group "#{name}-ssh" do
  inbound_rules [{:ports => 22, :protocol => :tcp, :sources => ['0.0.0.0/0']}]
end

aws_security_group "#{name}-http" do
  inbound_rules [{:ports => 80, :protocol => :tcp, :sources => ['0.0.0.0/0']}]
end


# specify what's needed to create a machine
with_machine_options({
  :bootstrap_options => {
    :instance_type => "t1.micro",
    :key_name => "aws-popup-chef",   # need my key here - alexv in projects/amazon folder
    :security_groups => [ "#{name}-ssh","#{name}-http"],
    # :region => 'us-west-2' # added by Alex

  },
  :ssh_username => "root",
  :image_id => "ami-b6bdde86"  # may need another ID. CentOS 6.5
})

# declare a machine to act as our web server
machine "#{name}-webserver-1" do
  recipe "webserver"
  tag "my-webserver"
  converge true
end