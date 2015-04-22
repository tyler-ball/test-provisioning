require 'chef/provisioning/aws_driver'
with_driver 'aws::us-west-2'

# aws_dhcp_options 'tyler-test-dhcp-options' do
# end

aws_vpc 'tyler-test-vpc' do
  action :delete
  cidr_block '10.0.31.0/24'
  internet_gateway true
  #main_routes '0.0.0.0/0' => :internet_gateway
  dhcp_options 'tyler-test-dhcp-options'
end

# aws_route_table 'tyler-test-public' do
#   vpc 'tyler-test-vpc'
#   routes '0.0.0.0/0' => :internet_gateway
# end

# aws_subnet 'tyler-test-subnet' do
#   vpc 'tyler-test-vpc'
#   map_public_ip_on_launch true
#   route_table 'tyler-test-public'
# end