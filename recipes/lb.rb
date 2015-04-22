require 'chef/provisioning/aws_driver'
with_driver 'aws::us-west-2'

aws_key_pair "tyler_provisioning_test" do
end

# (1..3).each do |i|
#   machine "tball_test_lb_#{i}" do
#     #action :destroy
#     machine_options bootstrap_options: {
#       key_name: 'tyler_provisioning_test',
#       instance_type: 't1.micro',
#       associate_public_ip_address: true
#     }
#   end
# end

machine "tball_test_lb" do
  #action :destroy
  machine_options bootstrap_options: {
    key_name: 'tyler_provisioning_test',
    instance_type: 't1.micro',
    associate_public_ip_address: true
  },
  convergence_options: {
    chef_version: '12.1.1'
  }
end

load_balancer "asdf" do
  action :nothing
  load_balancer_options({
    :listeners => [
      {
        :protocol => :http,
        :port => 8083,
        :instance_port => 8083,
        :instance_protocol => :https,
        #:ssl_certificate_id => 123
      }
    ],
    :availability_zones => ['us-west-2a', 'us-west-2b', 'us-west-2c'],
    :scheme => 'internet-facing',
    #:subnets => ['subnet-eacb348f', 'subnet-5bbda12f', 'subnet-fa1e21bc'],
    #:subnets => ['subnet-25fcec63'],
    #:security_group_ids => [],
  })
  #machines ["tball_test_lb_3"]
end

# default - sg-e602de83
# sg-53f54a36 
# sg-2b1ea64e