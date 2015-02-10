#
# Cookbook Name:: metal
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require "chef/provisioning/aws_driver"
with_driver "aws"

name = "alexv"

with_machine_options({
  :bootstrap_options => {
    :instance_type => "t1.micro",
    ### This has to be YOUR keypair name
    :key_name => "alexv",
    ### If no SG is specified, default is used.
    ### If default does not have SSH you will fail
    # :security_group_ids => ['sg-7c895119']  
  },
  ### This has to be a valid ami
  :image_id => 'ami-b6bdde86',
  ### This has to be a username associated with .pem file
  :ssh_username => "root"
})

# # declare security groups
# aws_security_group "#{name}-ssh" do
#   inbound_rules [{:ports => 22, :protocol => :tcp, :sources => ['0.0.0.0/0']}]
# end

# aws_security_group "#{name}-http" do
#   inbound_rules [{:ports => 80, :protocol => :tcp, :sources => ['0.0.0.0/0']}]
# end



# Declare a machine to act as our web server
machine "#{name}-webserver-1" do
  recipe "webserver"
  tag "#{name}-webserver"
  converge true
end

# # Declare a machine to act as our 2nd web server
# machine "#{name}-webserver-2" do
#   recipe "webserver"
#   tag "#{name}-webserver"
#   converge true
# end

## Setting up empty array
elb_instances = []


machine_batch 'hello_world' do
  1.upto(10) do |n|
    instance = "#{name}-webserver-#{n}"
    machine instance do
      machine_options ({
        bootstrap_options: { 
          :instance_type => "t1.micro",
          image_id: 'ami-b6bdde86',
          :key_name => "alexv"},
        :ssh_username => "root"})
      recipe "webserver"
      tag "#{name}-webserver"
      converge true
    end
    ## Populating array with instance name on each loop.
    elb_instances << instance
  end
end

## Creating load balancer
load_balancer "#{name}-webserver-lb" do
  load_balancer_options({
    :availability_zones => ["us-west-2a", "us-west-2b", "us-west-2c"],
    :listeners => [{:port => 80, :protocol => :http, :instance_port => 80, :instance_protocol => :http }],
    ## Example of using security group we created
    # :security_group_name => "#{name}-http"
    ## Example of using existing security group
    # :security_group_ids => ['sg-7c895119']
  })
  ## Passing array as a list of machines to the load balancer
  machines elb_instances
end




