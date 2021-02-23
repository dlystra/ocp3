ec2-instance
=========

non-idempotently deploys EC2 instances (will not destroy pre-existing stuff)


Requirements
------------

- Configured ec2.py and ec2.ini for dynamic inventory script usage

Role Variables
--------------

| var name         	| type        	| default                                   	| description                                                  	| required 	|
|------------------	|-------------	|-------------------------------------------	|--------------------------------------------------------------	|----------	|
| instance_type    	| string      	|                                           	| AWS instance type (ex: m5.xlarge)                            	| yes      	|
| image            	| string      	| all vars `default_image` or env defined   	| ami name if not using environment-wide ami                   	|          	|
| assign_public_ip 	| bool        	| no                                        	| whether or not you want a public IP assigned to the instance 	|          	|
| volumes          	| list        	|                                           	| list of EBS-backed volumes to attach to the instance         	| yes      	|
| server           	| parent dict 	|                                           	| placeholder                                                  	| yes      	|
| security_groups  	| array       	| all vars `security_groups` or env defined 	| security groups to apply to the instance                     	|          	|
| type             	| string      	|                                           	| tag instance with "Type" key. purely subjective.             	| yes      	|
| iam_profile      	| string      	| all vars `default_iam` or env defined     	| iam profile to apply to the instance                         	|          	|
| count            	| int         	|                                           	| how many of this instance you want to deploy                 	| yes      	|
| ec2_instance_destroy   	| bool         	| "{{ marked_for_decomission }}"                                          	| if you want to destroy instance                	| no      	|
Dependencies
------------

boto3 installed on local host

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables
passed in as parameters) is always nice for users too:
~~~
  ---
  - hosts: localhost
    connection: local
    gather_facts: false

    vars_files: ./inventories/registry/group_vars/tag_Function_Tower.yml

    roles:
    - ec2-instance
~~~

Example instance vars block:
~~~
  servers:
    - type: TowerDB
      count: 1
      instance_type: m5.xlarge
      function: "Tower"
      volumes:
        - "{{ base_volume }}"
~~~

Example instance vars block with additional disks:
~~~
  servers:
    - type: OSE_Master
      count: 1
      assign_public_ip: no
      instance_type: m5.xlarge
      security_groups: "{{ ocp_master_sgs }}"
      iam_profile: "{{ ocp_master_iam }}"
      function: "OpenShift"
      volumes:
        - "{{ base_volume }}"
        - device_name: /dev/sdb
          volume_size: 100
          delete_on_termination: yes
        - device_name: /dev/sdc
          volume_size: 100
          delete_on_termination: yes
~~~

Author Information
------------------

- Too many people
- documented by Chris Kuperstein <ckuperst@redhat.com>
