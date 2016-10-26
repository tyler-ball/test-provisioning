require 'chef/provisioning/aws_driver'

with_driver 'aws:tester:us-west-2'



# aws_vpc 'tyler_test_vpc' do
#   action :purge
# end

# aws_vpc 'tyler_test_vpc' do
#   cidr_block '192.168.0.0/16'
#   internet_gateway true
#   enable_dns_hostnames true
#   main_routes '0.0.0.0/0' => :internet_gateway
# end
#
# aws_key_pair 'tyler_test_provisioning' do
#   allow_overwrite true
# end
#
# aws_security_group 'tyler_test_sg' do
#   vpc 'tyler_test_vpc'
#   inbound_rules [
#     {:port => -1, :protocol => -1, :sources => ["24.242.112.5/32"] }
#   ]
#   outbound_rules [
#     {:port => -1, :protocol => -1, :destinations => ["0.0.0.0/0"] }
#   ]
# end
#
# aws_subnet 'tyler_test_subnet' do
#   vpc 'tyler_test_vpc'
#   cidr_block '192.168.0.0/24'
#   map_public_ip_on_launch true
#   availability_zone lazy { (driver.ec2_client.describe_availability_zones.availability_zones.map {|r| r.zone_name}).first }
# end
#
# machine 'tyler_test' do
#   machine_options bootstrap_options: {
#     key_name: 'tyler_test_provisioning',
#     security_group_ids: 'tyler_test_sg',
#     instance_type: 'm3.medium',
#     subnet_id: 'tyler_test_subnet'
#   }
#   action :ready
# end

machine "novpc" do
  machine_options bootstrap_options: {
    key_name: 'tyler_test_provisioning',
    instance_type: 'm3.medium',
  }
end

load_balancer "testnovpc" do
  machine "novpc"
end
