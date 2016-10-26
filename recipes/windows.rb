require 'chef/provisioning/aws_driver'

with_driver 'aws:tester:us-west-2'

with_chef_server("https://api.chef.io/organizations/tyler2",
  :client_name => "tball",
  :signing_key_filename => "/Users/tball/.chef/tball.pem")

aws_vpc 'tyler_test_vpc' do
  cidr_block '192.168.0.0/16'
  internet_gateway true
  enable_dns_hostnames true
  main_routes '0.0.0.0/0' => :internet_gateway
end

aws_key_pair 'tyler_test_provisioning' do
  allow_overwrite true
end

aws_security_group 'tyler_test_sg' do
  vpc 'tyler_test_vpc'
  inbound_rules [
    {:port => -1, :protocol => -1, :sources => ["173.174.38.129/32"] }
  ]
  outbound_rules [
    {:port => -1, :protocol => -1, :destinations => ["0.0.0.0/0"] }
  ]
end

aws_subnet 'tyler_test_subnet' do
  vpc 'tyler_test_vpc'
  cidr_block '192.168.0.0/24'
  map_public_ip_on_launch true
  availability_zone lazy { (driver.ec2_client.describe_availability_zones.availability_zones.map {|r| r.zone_name}).first }
end

# user = "tyler"
# password = "lL!Wctc8PHFI1d"
# # lifted from kitchen-ec2
# user_data = <<-USER_DATA
# <powershell>
# $logfile="C:\\Program Files\\Amazon\\Ec2ConfigService\\Logs\\chef-provisioning.log"
# #PS Remoting and & winrm.cmd basic config
# Enable-PSRemoting -Force -SkipNetworkProfileCheck
# & winrm.cmd set winrm/config '@{MaxTimeoutms="1800000"}' >> $logfile
# & winrm.cmd set winrm/config/winrs '@{MaxMemoryPerShellMB="1024"}' >> $logfile
# & winrm.cmd set winrm/config/winrs '@{MaxShellsPerUser="50"}' >> $logfile
# #Server settings - support username/password login
# & winrm.cmd set winrm/config/service/auth '@{Basic="true"}' >> $logfile
# & winrm.cmd set winrm/config/service '@{AllowUnencrypted="true"}' >> $logfile
# & winrm.cmd set winrm/config/winrs '@{MaxMemoryPerShellMB="1024"}' >> $logfile
# #Firewall Config
# & netsh advfirewall firewall set rule name="Windows Remote Management (HTTP-In)" profile=public protocol=tcp localport=5985 remoteip=localsubnet new remoteip=any  >> $logfile
# "Disabling Complex Passwords" >> $logfile
# $seccfg = [IO.Path]::GetTempFileName()
# & secedit.exe /export /cfg $seccfg >> $logfile
# (Get-Content $seccfg) | Foreach-Object {$_ -replace "PasswordComplexity\\s*=\\s*1", "PasswordComplexity = 0"} | Set-Content $seccfg
# & secedit.exe /configure /db $env:windir\\security\\new.sdb /cfg $seccfg /areas SECURITYPOLICY >> $logfile
# & cp $seccfg "c:\\"
# & del $seccfg
# $username="#{user}"
# $password="#{password}"
# "Creating static user: $username" >> $logfile
# & net.exe user /y /add $username $password >> $logfile
# "Adding $username to Administrators" >> $logfile
# & net.exe localgroup Administrators /add $username >> $logfile
# </powershell>
# USER_DATA

# machine 'tyler_test' do
#   machine_options bootstrap_options: {
#     key_name: 'tyler_test_provisioning',
#     security_group_ids: 'tyler_test_sg',
#     instance_type: 'm3.medium',
#     subnet_id: 'tyler_test_subnet'
#   }
#   action :destroy
# end

machine 'tyler_test_windows' do
  machine_options(
    bootstrap_options: {
      image_id: 'ami-2827f548',
      key_name: 'tyler_test_provisioning',
      security_group_ids: 'tyler_test_sg',
      instance_type: 'm3.medium',
      subnet_id: 'tyler_test_subnet',
      #user_data: user_data
    },
    #winrm_password: 'lL!Wctc8PHFI1d',
    #winrm_transport: 'https',
    is_windows: true
  )
  # action :nothing
  # action :allocate
  # action [:destroy, :converge]
  # action :destroy
end

# aws_vpc 'tyler_test_vpc' do
#   action :purge
# end
