require 'net/ssh'
require 'net/ssh/proxy/jump'

host = "10.221.207.36"
user = "ubuntu"
keys = ["/home/ubuntu/.ssh/multipass_key"]
# jump_proxy = 'dialog@10.249.254.37'

# jump_proxy = Net::SSH::Proxy::Jump.new('dialog@10.249.254.37')

# Net::SSH.start(host, user, keys: keys, proxy: jump_proxy) do |ssh|
Net::SSH.start(host, user, keys: keys) do |ssh|

	result = ssh.exec! "ls -l"
	puts result
	
	result = ssh.exec! "sudo mkdir /etc/test-1"
	puts result
end
