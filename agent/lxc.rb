require 'lxc'

module MCollective
	module Agent
		class Lxc<RPC::Agent
			action "list" do
				LXC.list_containers.each do |x|
					reply[x]=Hash.new
					cnt=LXC::Container.new(x)
					reply[x][:name]=cnt.name
					reply[x][:state]=cnt.state
					reply[x][:ip]=cnt.ip_addresses
					if cnt.state == :running 
						reply[x][:memused]=cnt.cgroup_item('memory.usage_in_bytes')
						reply[x][:memlimit]=cnt.cgroup_item('memory.limit_in_bytes')
						reply[x][:cpushares]=cnt.cgroup_item('cpu.shares')
					end
				end
			end
			action "start" do
				#for sorrow, shelling out here to try to work around zombie issue #2
				run("/usr/bin/lxc-start -d -n #{request[:name]}")
				cnt=LXC::Container.new(request[:name])
				#cnt.start
				reply[:state]=cnt.state
				reply[:name]=cnt.name
			end
			action "stop" do
				cnt=LXC::Container.new(request[:name])
				cnt.stop
				reply[:state]=cnt.state
				reply[:name]=cnt.name
			end
			action "restart" do
				cnt=LXC::Container.new(request[:name])
				cnt.stop
				cnt.start
				reply[:state]=cnt.state
				reply[:name]=cnt.name
			end
			action "create" do
				cnt=LXC::Container.new(request[:name])
				tempopts=request[[:templateopts]] || []
				cnt.create(request[:templatename],nil,{},0,tempopts)
				reply[:state]=cnt.state
				reply[:name]=cnt.name
			end
			action "destroy" do
				cnt=LXC::Container.new(request[:name])
				cnt.destroy
				reply[:state]="DESTROYED"
				reply[:name]=cnt.name
			end
			action "get_config_item" do
				reply[:configvalue]=LXC::Container.new(request[:name]).config_item(request[:configkey])
				reply[:configkey]=request[:configkey]
				reply[:name]=request[:name]
			end
			action "set_config_item" do
				cnt=LXC::Container.new(request[:name])
				cnt.set_config_item(request[:configkey],request[:configvalue])
				cnt.save_config
				reply[:configvalue]=cnt.config_item(request[:configkey])
				reply[:configkey]=request[:configkey]
				reply[:name]=cnt.name
			end
		end
	end
end
