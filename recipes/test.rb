require 'chef/provisioning/aws_driver'
require 'retryable'

with_driver 'aws::eu-west-1'

# TODO we should accept either strings or symbols
aws_ebs_volume 'tag-test1' do
  tags { :first => :value }
end

aws_ebs_volume 'tag-test2' do
  tags { 'Name' => 'tag-test22' }
end

aws_eip_address 'test-eip' do
  tags { 'Name' => 'tag-test22' }
end