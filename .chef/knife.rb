# See http://docs.opscode.com/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :error
log_location             STDOUT
node_name                "YOURNODE"
client_key               "#{current_dir}/keys/chef_default"
validation_client_name   "chef_default"
validation_key           "#{current_dir}/keys/chef_default"
# chef_server_url          "https://api.opscode.com/organizations/your_org"
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
cookbook_path            ["#{current_dir}/../cookbooks"]

##Knife EC2
# knife[:aws_access_key_id] = 'aaaaaaaaa'
# knife[:aws_secret_access_key] = 'bbbbbbbbb'
# knife[:region] = 'us-west-2'

# ~/.aws/config equivalent
# aws_access_key_id = aaaaaaaaa
# aws_secret_access_key = bbbbbbbbb

