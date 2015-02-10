#
# Cookbook Name:: metal
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require "chef/provisioning/aws_driver"
with_driver "aws"

name = "alexv"


## Destroy webserver 1
machine "#{name}-webserver-1" do
  action :destroy
end

## Destroy webserver 2
# machine "#{name}-webserver-2" do
#   action :destroy
# end

## Destroy all servers
# machine_batch do
#   machines search(:node, '*:*').map { |n| n.name }
#   action :destroy
# end

## Destroy a range of machines
# machine_batch 'goodbye_cruel_world' do
#   1.upto(20) do |n|
#     machine "#{name}-webserver-#{n}"
#   end
#   action :destroy
# end

## Destroy a load balancer
# load_balancer "#{name}-webserver-lb" do
#   action :destroy
# end

## Setting machine options when chef localmode is not used.
# with_machine_options({
#   :bootstrap_options => {
#     :key_name => "alexv",
#   },
#   :ssh_username => "root"
# })
