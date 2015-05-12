require 'chef/provisioning/aws_driver'

with_driver 'aws::eu-west-1'

aws_vpc 'ref-vpc' do
  cidr_block '10.0.0.0/24'
end

aws_network_acl "first_test" do
  vpc 'ref-vpc'
end

aws_network_acl "first_test" do
  action :destroy
end

aws_vpc 'ref-vpc' do
  action :destroy
end