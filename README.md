mcollective-lxc-agent
=====================

MCollective SimpleRPC Agent for managing LXC containers on multiple hosts.  

* Being developed on Ubuntu Trusty (14.04).
* The goal is to use the [LXC API Ruby Bindings](https://github.com/lxc/ruby-lxc) as much as possible.
* Inspiration taken from [https://github.com/nadeau/mcollective-plugins](https://github.com/nadeau/mcollective-plugins) and [https://github.com/ranjib/lxc-cookbook](https://github.com/ranjib/lxc-cookbook)

Requirements and Notes
----------------------

Create debian packages with:

    root@client:~# apt-get install devscripts debhelper dpatch cdbs
    root@client:/tmp# mco plugin package /home/me/clone/mcollective-lxc-agent

On LXC hosts:

    root@lxchost1:~# apt-get install lxc lxc-dev build-essential ruby-dev mcollective-lxc-agent mcollective-lxc-common
    root@lxchost1:~# gem install ruby-lxc

On clients: 

    root@client:~# apt-get install mcollective-lxc-common


Examples
========

    

    me@client:~$ sudo mco rpc lxc create name=test1 templatename='ubuntu'
    Discovering hosts using the mc method for 2 second(s) .... 1

     * [ ==========================================================> ] 1 / 1


    lxchost1                                  
        Name: test1
       State: :stopped



    Finished processing 1 / 1 hosts in 7456.72 ms

    me@client:~$ sudo mco rpc lxc create name=test2 templatename='ubuntu' templateopts='-r lucid'
    Discovering hosts using the mc method for 2 second(s) .... 1

     * [ ==========================================================> ] 1 / 1


    lxchost1                                  
        Name: test2
       State: :stopped


    me@client:~$ sudo mco rpc lxc set_config_item name=test1 configvalue='10.0.4.66/24' configkey='lxc.network.0.ipv4' 
    Discovering hosts using the mc method for 2 second(s) .... 1

     * [ ==========================================================> ] 1 / 1


    lxchost1                                  
         Key: lxc.network.0.ipv4
       Value: ["10.0.4.66"]
        Name: test1



    Finished processing 1 / 1 hosts in 34.70 ms

    me@client:~$ sudo mco rpc lxc start name=test1
    Discovering hosts using the mc method for 2 second(s) .... 1

     * [ ==========================================================> ] 1 / 1


    lxchost1                                  
        Name: test1
       State: :running



    Finished processing 1 / 1 hosts in 382.95 ms


    me@client:~$ sudo mco rpc lxc list -v
    Discovering hosts using the mc method for 2 second(s) .... 1

     * [ ==========================================================> ] 1 / 1


    lxchost1                                 : OK
    {:name=>nil,     :ip=>nil,     :state=>nil,     "test1"=>{:name=>"test1", :state=>:running, :ip=>["10.0.4.61", "10.0.4.66"]},     "test2"=>{:name=>"test2", :state=>:stopped, :ip=>[]}}



    ---- lxc#list call stats ----
               Nodes: 1 / 1
         Pass / Fail: 1 / 0
          Start Time: 2014-08-19 15:57:17 -0700
      Discovery Time: 2032.23ms
          Agent Time: 382.15ms
          Total Time: 2414.38ms
 


lxc (full description)
=====================

Create and manage LXC containers

      Author: Brandon Rochon
     Version: 0.1
     License: MIT
     Timeout: 1024
   Home Page: https://github.com/br0ch0n/mcollective-lxc-agent

ACTIONS:
========
   create, destroy, get_config_item, list, restart, set_config_item, start, stop

   create action:
   --------------
       Create a new container

       INPUT:
           name:
              Description: Name of container to create
                   Prompt: New container name
                     Type: string
                 Optional: false
               Validation: ^[a-zA-Z\-_\d]+$
                   Length: 64

           templatename:
              Description: Name of template to use, e.g. ubuntu
                   Prompt: Template name
                     Type: string
                 Optional: false
               Validation: ^[a-zA-Z\-_\d]+$
                   Length: 64

           templateopts:
              Description: Options to pass to template, e.g. '-r lucid' 
                   Prompt: Template options
                     Type: string
                 Optional: true
               Validation: .*
                   Length: 64


       OUTPUT:
           name:
              Description: Container name
               Display As: Name

           state:
              Description: Container state
               Display As: State

   destroy action:
   ---------------
       Destroy a container

       INPUT:
           name:
              Description: Name of container to destroy
                   Prompt: Container on death row
                     Type: string
                 Optional: false
               Validation: ^[a-zA-Z\-_\d]+$
                   Length: 64


       OUTPUT:
           name:
              Description: Container name
               Display As: Name

           state:
              Description: Container state
               Display As: State

   get_config_item action:
   -----------------------
       Return value for specified key on a named container

       INPUT:
           configkey:
              Description: Name of config key
                   Prompt: Key to query
                     Type: string
                 Optional: false
               Validation: ^[a-zA-Z\-_\.:\d]+$
                   Length: 164

           name:
              Description: Name of container to request config from
                   Prompt: Container to query
                     Type: string
                 Optional: false
               Validation: ^[a-zA-Z\-_\d]+$
                   Length: 64


       OUTPUT:
           configkey:
              Description: Container config key
               Display As: Key

           configvalue:
              Description: Container config value
               Display As: Value

           name:
              Description: Container name
               Display As: Name

   list action:
   ------------
       List all containers

       INPUT:
          This action does not have any inputs

       OUTPUT:
           ip:
              Description: Container IP address
               Display As: IP

           name:
              Description: Container name
               Display As: Name

           state:
              Description: Container state
               Display As: State

   restart action:
   ---------------
       Restart a named container

       INPUT:
           name:
              Description: Name of container to restart
                   Prompt: Container to restart
                     Type: string
                 Optional: false
               Validation: ^[a-zA-Z\-_\d]+$
                   Length: 64


       OUTPUT:
           name:
              Description: Container name
               Display As: Name

           state:
              Description: Container state
               Display As: State

   set_config_item action:
   -----------------------
       Set specified value for specified key on a named container

       INPUT:
           configkey:
              Description: Name of config key
                   Prompt: Key to edit value of
                     Type: string
                 Optional: false
               Validation: ^[a-zA-Z\-_\.:\d]+$
                   Length: 164

           configvalue:
              Description: Name of config value
                   Prompt: Value to set
                     Type: string
                 Optional: false
               Validation: ^[a-zA-Z\-_\.:\d/]+$
                   Length: 164

           name:
              Description: Name of container to set config on
                   Prompt: Container to edit
                     Type: string
                 Optional: false
               Validation: ^[a-zA-Z\-_\d]+$
                   Length: 64


       OUTPUT:
           configkey:
              Description: Container config key
               Display As: Key

           configvalue:
              Description: Container config value
               Display As: Value

           name:
              Description: Container name
               Display As: Name

   start action:
   -------------
       Start a named container

       INPUT:
           name:
              Description: Name of container to start
                   Prompt: Container to start
                     Type: string
                 Optional: false
               Validation: ^[a-zA-Z\-_\d]+$
                   Length: 64


       OUTPUT:
           name:
              Description: Container name
               Display As: Name

           state:
              Description: Container state
               Display As: State

   stop action:
   ------------
       Stop a named container

       INPUT:
           name:
              Description: Name of container to stop
                   Prompt: Container to stop
                     Type: string
                 Optional: false
               Validation: ^[a-zA-Z\-_\d]+$
                   Length: 64


       OUTPUT:
           name:
              Description: Container name
               Display As: Name

           state:
              Description: Container state
               Display As: State

