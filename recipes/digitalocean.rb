require 'chef/provisioning/fog_driver/driver'

with_driver 'fog:DigitalOcean'

with_machine_options(
   :bootstrap_options => {
     image_distribution: 'Ubuntu',
     image_name: '14.04 x64',
     #region_name: 'San Francisco 1',
     region_id: 3,
     key_name: 'tyler_digitalocean'
   }
)

fog_key_pair "tyler_digitalocean" do
end

machine 'testbox' do
  action :destroy
  tag 'itsname'
end
