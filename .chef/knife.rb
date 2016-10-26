# This file exists mainly to ensure we don't pick up knife.rb from anywhere else
config_dir "#{File.expand_path('..', __FILE__)}/" # Wherefore art config_dir, chef?
private_key_paths [ File.expand_path('./.chef/keys', ENV["HOME"]), File.expand_path('./.ssh', ENV["HOME"]) ]

cookbook_path            '/Users/tball/chef_repo/cookbooks'
chef_repo_path           '/Users/tball/chef_repo/cookbooks/test-provisioning'

# Chef 11.14 binds to "localhost", which interferes with port forwarding on IPv6 machines for some reason
#begin
#  chef_zero.host '127.0.0.1'
#end

# https://github.com/chef/chef-provisioning/issues/330
# Amazon AWS
# knife[:aws_access_key_id] = ENV['AWS_ACCESS_KEY_ID']
# knife[:aws_secret_access_key] = ENV['AWS_SECRET_ACCESS_KEY']

# Bootstrap with Chef-Zero
#knife[:ssh_user] = "ec2-user"
#chef_zero[:port] = "8890"

#audit_mode :enabled

#chef_provisioning({:aws_retry_limit => 25})
chef_provisioning(:image_max_wait_time => 600, :machine_max_wait_time => 300)

# For testing stuff with a real chef server, copied from ~/.chef/knife.rb
log_level                :warn
log_location             STDOUT
node_name                "tball"
client_key               "/Users/tball/.chef/tball.pem"
#validation_client_name   "tyler2-validator"
#validation_key           "#{current_dir}/tyler2-validator.pem"
chef_server_url          "https://api.chef.io/organizations/tyler2"
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
