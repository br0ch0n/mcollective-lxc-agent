metadata	:name		=> "lxc",
		:description	=> "Create and manage LXC containers",
		:author		=> "Brandon Rochon",
		:license	=> "MIT",
		:version	=> "0.2",
		:url		=> "https://github.com/br0ch0n/mcollective-lxc-agent",
		:timeout	=> 1024

action "list", :description => "List all containers" do
	display :always

end

action "start", :description => "Start a named container" do
	display :always

	input	:name,
		:description => "Name of container to start",
		:prompt      => "Container to start",
		:type        => :string,
		:maxlength   => 64,
		:validation  => '^[a-zA-Z\-_\d]+$',
		:optional    => false

	output	:state,
		:description => "Container state",
		:display_as  => "State"

	output	:name,
		:description => "Container name",
		:display_as  => "Name"

end

action "stop", :description => "Stop a named container" do
	display :always

	input	:name,
		:description => "Name of container to stop",
		:prompt      => "Container to stop",
		:type        => :string,
		:maxlength   => 64,
		:validation  => '^[a-zA-Z\-_\d]+$',
		:optional    => false

	output	:state,
		:description => "Container state",
		:display_as  => "State"

	output	:name,
		:description => "Container name",
		:display_as  => "Name"

end

action "restart", :description => "Restart a named container" do
	display :always

	input	:name,
		:description => "Name of container to restart",
		:prompt      => "Container to restart",
		:type        => :string,
		:maxlength   => 64,
		:validation  => '^[a-zA-Z\-_\d]+$',
		:optional    => false

	output	:state,
		:description => "Container state",
		:display_as  => "State"

	output	:name,
		:description => "Container name",
		:display_as  => "Name"

end

action "create", :description => "Create a new container" do
	display :always

	input	:name,
		:description => "Name of container to create",
		:prompt      => "New container name",
		:type        => :string,
		:maxlength   => 64,
		:validation  => '^[a-zA-Z\-_\d]+$',
		:optional    => false

	input	:templatename,
		:description => "Name of template to use, e.g. ubuntu",
		:prompt      => "Template name",
		:type        => :string,
		:maxlength   => 64,
		:validation  => '^[a-zA-Z\-_\d]+$',
		:optional    => false

	input	:templateopts,
		:description => "Options to pass to template, e.g. '-r lucid' ",
		:prompt      => "Template options",
		:type        => :string,
		:maxlength   => 64,
		:validation  => '.*',
		:optional    => true

	output	:state,
		:description => "Container state",
		:display_as  => "State"

	output	:name,
		:description => "Container name",
		:display_as  => "Name"

end

action "destroy", :description => "Destroy a container" do
	display :always

	input	:name,
		:description => "Name of container to destroy",
		:prompt      => "Container on death row",
		:type        => :string,
		:maxlength   => 64,
		:validation  => '^[a-zA-Z\-_\d]+$',
		:optional    => false

	output	:state,
		:description => "Container state",
		:display_as  => "State"

	output	:name,
		:description => "Container name",
		:display_as  => "Name"

end

action "get_config_item", :description => "Return value for specified key on a named container" do
	display :always

	input	:name,
		:description => "Name of container to request config from",
		:prompt      => "Container to query",
		:type        => :string,
		:maxlength   => 64,
		:validation  => '^[a-zA-Z\-_\d]+$',
		:optional    => false

	input	:configkey,
		:description => "Name of config key",
		:prompt      => "Key to query",
		:type        => :string,
		:maxlength   => 164,
		:validation  => '^[a-zA-Z\-_\.:\d]+$',
		:optional    => false

	output	:configkey,
		:description => "Container config key",
		:display_as  => "Key"

	output	:configvalue,
		:description => "Container config value",
		:display_as  => "Value"

	output	:name,
		:description => "Container name",
		:display_as  => "Name"

end

action "set_config_item", :description => "Set specified value for specified key on a named container" do
	display :always

	input	:name,
		:description => "Name of container to set config on",
		:prompt      => "Container to edit",
		:type        => :string,
		:maxlength   => 64,
		:validation  => '^[a-zA-Z\-_\d]+$',
		:optional    => false

	input	:configkey,
		:description => "Name of config key",
		:prompt      => "Key to edit value of",
		:type        => :string,
		:maxlength   => 164,
		:validation  => '^[a-zA-Z\-_\.:\d]+$',
		:optional    => false

	input	:configvalue,
		:description => "Name of config value",
		:prompt      => "Value to set",
		:type        => :string,
		:maxlength   => 164,
		:validation  => '^[a-zA-Z\-_\.:\d/]+$',
		:optional    => false

	output	:configkey,
		:description => "Container config key",
		:display_as  => "Key"

	output	:configvalue,
		:description => "Container config value",
		:display_as  => "Value"

	output	:name,
		:description => "Container name",
		:display_as  => "Name"

end
