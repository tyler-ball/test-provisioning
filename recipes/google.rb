require 'chef/provisioning/google_driver'

with_driver 'google:us-central1-a:inspired-bebop-518',
  :google_credentials => {
    :p12_path => '/Users/tball/Downloads/My Project-51461cd3911a.p12',
    :issuer => '1028669279069-paf5g92g2vrdtfle1ott1ahrabkcu47l@developer.gserviceaccount.com',
    :passphrase => 'notasecret'
  }

machine 'test' do
  machine_options bootstrap_options: {
    :machineType=>"zones/us-central1-a/machineTypes/f1-micro",
    :name=>"instance-2",
    :disks=>[{
      :deviceName => "instance-2",
      :autoDelete=>true,
      :boot=>true,
      :initializeParams=>{
        :sourceImage=>"projects/coreos-cloud/global/images/coreos-stable-607-0-0-v20150317"
      },
      :type=>"PERSISTENT"
    }],
    :networkInterfaces=>[{:network=>"global/networks/default", :name => "nic0"}]
  }
end