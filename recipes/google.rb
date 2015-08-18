require 'chef/provisioning/google_driver'

# TODO stuff credentials in config.rb or knife.rb if there is not an existing pattern in
# the SDK for loading credentials - https://developers.google.com/cloud/sdk/gcloud/reference/compute/?hl=en_US
with_driver 'google:us-central1-a:inspired-bebop-518',
  :google_credentials => {
    :p12_path => '/Users/tball/Downloads/My Project-fe0a9c743984.p12',
    :issuer => '1028669279069-r1b50mja60fsqev4dupa999tutus68cr@developer.gserviceaccount.com',
    :passphrase => 'notasecret'
  }

# google_key_pair "chef_default" do
#   private_key_path "google_default"
#   public_key_path "google_default.pub"
# end

machine 'test' do
  machine_options key_name: "google_default"
  action :destroy
end

load_balancer "test"

# TODO

# machine_batch "batch" do
#   (1..10).each do |i|
#     machine i
#   end
# end

# load_balancer "lb"

# machine_image "image"

# google_firewall_rules
