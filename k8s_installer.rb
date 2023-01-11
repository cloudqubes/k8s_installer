require 'net/ssh'
require_relative 'file_man'

host = "10.221.207.36"
user = "ubuntu"
keys = ["/home/ubuntu/.ssh/multipass_key"]
proxy_string= "http://127.0.0.1:8001"

# execute ssh command and block until completion
def ssh_execute!(ssh_session, command)
	ssh_session.exec! command do | ch, stream, data |
		if stream == :stderr
			puts "Error #{data}"
		else
			puts data
		end
	end
end



Net::SSH.start(host, user, keys: keys) do |ssh|

	# set proxy
	ssh.exec! "export http_proxy=http://127.0.0.1:8001"
	ssh.exec! "export https_proxy=http://127.0.0.1:8001"

	# update apt
	ssh.exec! "sudo apt-get update" do | ch, stream, data |
		if stream == :stderr
			puts "Error #{data}"
		else
			puts data
		end
	end
	
	## prerequisites for installing the container runtime
	# Load kernal modules
	command_string = "cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf\n"\
				"overlay\n"
				'br_netfilter\n'
				'EOF\n'
				
	ssh_execute!(ssh, command_string)
	ssh_execute!(ssh, "sudo modprobe overlay")
	ssh_execute!(ssh, "sudo modprobe br_netfilter")
	
	command_string = "cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf\n"
									 "net.bridge.bridge-nf-call-iptables  = 1\n"\
									 "net.bridge.bridge-nf-call-ip6tables = 1\n"\
									 "net.ipv4.ip_forward                 = 1\n"\
									 "EOF"
	
# 	result = ssh.exec! "sudo mkdir /etc/test-1"
# 	puts result
end

