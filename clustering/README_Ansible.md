# Using Ansible to install OpenVidu

## Prerequisites

### Clone the repo

```
$ git clone https://github.com/openvidu/openvidu-cloud-devops
$ cd openvidu-cloud-devops/clustering
```

### Local Machine

You need Ansible installed on your laptop or wherever you are running this playbook. To install Ansible run the following commnads:

```
$ sudo apt-add-repository -y ppa:ansible/ansible
$ sudo apt-get update 
$ sudo apt-get install -y ansible
```

Besides, you need to install this role:

`ansible-galaxy install -p /etc/ansible/roles geerlingguy.docker`

## Instances

You need 1 instance for OpenVidu Server and at least 1 more for Kurento Media Server with a minimum of 2 cpus and 8gigs of RAM. All instances should be accesible by SSH from your laptop. We use Ubuntu 16.04 Xenial.

The instances (all of then) need Python to be installed.

`$ sudo apt update; sudo apt install -y python`

## Security Groups

* OpenVidu Pro Server

  - 4443 TCP (OpenVidu Server listens on port 4443 by default)
  - 3478 TCP (COTURN listens on port 3478 by default)
  - 49152 - 65535 UDP (these ports are strongly recommended to be opened, as WebRTC randomly exchanges media through any of them)

* Kurento Media Server

  - 8888 TCP
  - 1024 - 65535 UDP
  - 1024 - 65535 TCP

## DNS Server

It's highly recomended to use a DNS server to register a FQDN for the OpenVidu instance.

## Inventory

As you probably alredy know, Ansible uses an inventory file to know which instances connect to and how to configure then. The inventory is a YAML file looks like

```
---
all:
  hosts:
    openvidu-server:
    kurento-server:
  vars:
      ansible_become: true
      ansible_user: USER
      ansible_ssh_private_key_file: /PATH/TO/SSH_public_key
  children:
    kurento:
      hosts:
        kurento-server:
      vars:
        ansible_host: KURENTO_SERVER_IP
    openvidu:
      hosts:
        openvidu-server
      vars: 
        ansible_host: OPENVIDU_SERVER_IP
```

You need to change:

  - `ansible_user`: the user you use to connect to the instances, i.e. Ubuntu Server Cloud uses _ubuntu_. If you've deployed those instances in OpenStack using Ubuntu Official Image, this will be the user. 
  - `ansible_ssh_private_key_file`: Path to the RSA private key you use to connect to your instances.
  - `OPENVIDU_SERVER_IP`: Public IP to connect to the instance.
  - `KURENTO_SERVER_IP`: Public IP to connect to the instance.

If you're using more than one Kurento Media Server, the inventory file will look like:

```
---
all:
  hosts:
    openvidu-server:
      ansible_host: X.Y.Z.W
    kurento-server-1:
      ansible_host: X.Y.Z.1
    kurento-server-2:
      ansible_host: X.Y.Z.2
    ...
    kurento-server-N:
      ansible_host: X.Y.Z.N
  vars:
      ansible_become: true
      ansible_user: USER
      ansible_ssh_private_key_file: /PATH/TO/SSH_public_key
  children:
    kurento:
      hosts:
        kurento-server-1:
        kurento-server-2:
        ...
        kurento-server-N:
    openvidu:
      hosts:
        openvidu-server:
```

## Group vars

In `group_vars/all` file you will find all the parameters we use to configure the infrastructure. Read all of then carefully as they don't have a default value.

For futher information check out https://openvidu.io/docs/reference-docs/openvidu-server-params/

### Deployment

First time you connect to an instance through SSH, it will ask you to confirm the instance fingerprint, so try to login into all the instances to accept the fingerprint so Ansible can do the job.

`ssh -i /PATH/TO/SSH_public_key USER@INSTANCE`

Replace the parameters by the apropiates values. Then you maybe want to check that Ansible can access the instances:

`ansible -i inventory.yml -m ping all`

This command will perform a _ping_ command in the instances, so we're now sure you have access to the instances and the inventory file is fine.

```
kurento-server-1 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    }, 
    "changed": false, 
    "ping": "pong"
}
openvidu-server | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    }, 
    "changed": false, 
    "ping": "pong"
}
```

Once you have completed all the information and parameters you can launch the playbook by running:

`ansible-playbook -i inventory.yml play.yml`

We'll know the deployment is ready checking the app's log in the OpenVidu server. So, first, connect to the instance:

`ssh -i /PATH/TO/SSH_public_key USER@OPENVIDU_INSTANCE`

And then, check the logs:

```
$ sudo -s
# cd /var/log/supervisor
# tail -f openvidu-server-stdout---supervisor-XXXX.log
```

XXXX means random characters. It should show something like:

```
[INFO] 2019-06-21 15:40:10,777 [main] org.springframework.boot.context.embedded.tomcat.TomcatEmbeddedServletContainer (start) - Tomcat started on port(s): 5443 (http)
[INFO] 2019-06-21 15:40:10,784 [main] io.openvidu.server.pro.OpenViduServerPro (whenReady) - Starting server monitoring
[INFO] 2019-06-21 15:40:10,786 [main] io.openvidu.server.pro.monitoring.OpenViduServerMonitor (startMonitoringGathering) - Local host net, cpu and mem usage is now being monitored (in an interval of 30 seconds)
[INFO] 2019-06-21 15:40:10,786 [main] io.openvidu.server.OpenViduServer (whenReady) - 

    ACCESS IP            
-------------------------
https://YOUR_DNS_NAME:4443/
-------------------------
```

Once it's installed you can access the service through the URL: _https://YOUR_DNS_NAME/inspector_ replace **YOUR_DNS_NAME** by your FQDN. Also, we provide a full featured Kibana Dashboard in _https://YOUR_DNS_NAME/kibana_ where you can check for performance and useful statics.

## Troubleshooting

If you get stuck deploying this playbooks remember we're here to help you. So please, when you open a new issue provide the full Ansible output log and, if you were able to deploy OpenVidu Server, please provide also the content of files:

- /var/log/cloud-init-output.log
- /var/log/supervisor/openvidu-server-stdout---supervisor-XXXX.log

XXXX means random characters.
