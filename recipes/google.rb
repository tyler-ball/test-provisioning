require 'chef/provisioning/google_driver'

# TODO stuff credentials in config.rb or knife.rb if there is not an existing pattern in
# the SDK for loading credentials - https://developers.google.com/cloud/sdk/gcloud/reference/compute/?hl=en_US
with_driver 'google:us-central1-a:inspired-bebop-518',
  :google_credentials => {
    :p12_path => '/Users/tball/Downloads/My Project-f409cb6c4775.p12',
    :issuer => '1028669279069-paf5g92g2vrdtfle1ott1ahrabkcu47l@developer.gserviceaccount.com',
    :passphrase => 'notasecret'
  }

google_key_pair "chef_default" do
  private_key_path "google_default"
  public_key_path "google_default.pub"
  # allow_overwrite true
  # private_key_options :regenerate_if_different => true, :size => 4096
end

google_key_pair "chef_default2" do
  private_key_path "/Users/tball/.chef/keys/google_default2"
  public_key_path "/Users/tball/.chef/keys/google_default2.pub"
end

# machine 'test' do
#   machine_options insert_options: {
#     :machineType=>"zones/us-central1-a/machineTypes/g1-small",
#   }
#   action :allocate
# end

# machine 'test' do
#   action :destroy
# end