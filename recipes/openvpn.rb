require 'chef/provisioning/aws_driver'

with_driver 'aws:tball:eu-central-1'

# aws_vpc 'openvpn_vpc' do
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
# aws_security_group 'openvpn_sg' do
#   vpc 'openvpn_vpc'
#   inbound_rules [
#     {:port => -1, :protocol => -1, :sources => ["72.183.199.76/32"] }
#   ]
#   outbound_rules [
#     {:port => -1, :protocol => -1, :destinations => ["0.0.0.0/0"] }
#   ]
# end
#
# aws_subnet 'openvpn_subnet' do
#   vpc 'openvpn_vpc'
#   cidr_block '192.168.0.0/24'
#   map_public_ip_on_launch true
#   availability_zone lazy { (driver.ec2_client.describe_availability_zones.availability_zones.map {|r| r.zone_name}).first }
# end

user_data = <<-USER_DATA
public_hostname=openvpn
admin_user=openvpn
admin_pw=openvpn
reroute_gw=1
reroute_dns=1
USER_DATA

# http://envyandroid.com/setup-free-private-vpn-on-amazon-ec2/
# machine 'openvpn_machine' do
#   machine_options bootstrap_options: {
#     image_id: 'ami-feced092',
#     key_name: 'tyler_test_provisioning',
#     security_group_ids: 'openvpn_sg',
#     instance_type: 't2.micro',
#     subnet_id: 'openvpn_subnet',
#     user_data: user_data
#   },
#   ssh_username: "openvpnas"
#   action :ready
#   #action [:destroy, :ready]
#   #action :destroy
# end

machine 'openvpn_machine' do
  action :destroy
end

aws_subnet 'openvpn_subnet' do
  action :destroy
end

aws_security_group 'openvpn_sg' do
  action :destroy
end

aws_vpc 'openvpn_vpc' do
  action :destroy
end
