require 'chef/provisioning/aws_driver'

with_driver 'aws::us-east-1'

# with_machine_options({
#   :bootstrap_options => {
#     key_name: 'ref-key-pair',
#     instance_type: 't2.medium',
#     image_id: 'ami-96a818fe',
#     security_group_ids: ['sg-d0d44fb5']
#   },
#   :ssh_username => 'centos',
#   :convergence_options => {
#     chef_version: '12.4.1',
#     ignore_failure: true
#   }
# })

aws_key_pair 'ref-key-pair' do
  private_key_options({
    :regenerate_if_different => true
  })
  allow_overwrite true
end

machine 'footyler' do
  action :ready
  machine_options({
    :bootstrap_options => {
      key_name: 'ref-key-pair',
      instance_type: 't2.medium',
      image_id: 'ami-96a818fe',
      security_group_ids: ['sg-d0d44fb5']
    },
    :ssh_username => 'centos',
    :convergence_options => {
      chef_version: '12.4.1',
      ignore_failure: true
    },
    :aws_tags => { :owner => 'tylerball', :tag1 => nil }
  })
end

machine 'footyler' do
  action [:converge, :destroy]
  run_list ['recipe[test-provisioning::audit]']
  chef_config "audit_mode :enabled"
  machine_options({
    :bootstrap_options => {
      key_name: 'ref-key-pair',
      instance_type: 't2.medium',
      image_id: 'ami-96a818fe',
      security_group_ids: ['sg-d0d44fb5']
    },
    :ssh_username => 'centos',
    :convergence_options => {
      chef_version: '12.4.1',
      ignore_failure: true
    },
    :aws_tags => { :owner => 'tylerball', :tag2 => nil }
  })
end
