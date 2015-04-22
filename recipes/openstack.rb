require 'chef/provisioning/fog_driver/driver'
with_driver 'fog:OpenStack'

# Credentials are on ~/.fog

fog_key_pair "tyler_openstack" do
end

machine 'test' do
  action :destroy
  machine_options bootstrap_options: {
    image_ref: '44908999-94d4-5648-ad49-b8dae1fe7820',
    flavor_ref: 101, # standard.small
    key_name: 'tyler_openstack'
  },
  ssh_username: 'fedora',
  floating_ip_pool: 'Ext-Net'
  #floating_ip: '15.125.90.250'
end