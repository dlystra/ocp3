ec2-sg
=========

This role creates EC2 Security Groups by feeding in a list of group items.

Requirements
------------

Local runner with access to the internet for installing pip, boto, and boto3. This role will install the dependencies automatically if host has internet access.

Role Variables
--------------
`vpc_id`: Target VPC ID
`region`: EC2 Region (Will take `AWS_DEFAULT_REGION` environment variable if not defined.)
`security_groups`: List of group items:
- `group`: Name of group name
- `description`: Group description
- `rules_inbound`: [List of inbound rules](https://devdocs.io/ansible~2.7/modules/ec2_group_module)
  - `proto`: _see above url_
  - `from_port`: _see above url_
  - `to_port`: _see above url_
  - `cidr_ip`: _see above url_
- `rules_outbound`: [List of outbound rules](https://devdocs.io/ansible~2.7/modules/ec2_group_module)
  - `proto`: _see above url_
  - `from_port`: _see above url_
  - `to_port`: _see above url_
  - `cidr_ip`: _see above url_

Example:
~~~
vpc_id: vpc-abc123456
region: us-gov-west-1
security_groups:
  - group: default
    description: Default Group (SSH and Ping)
    rules_inbound:
      - proto: tcp
        from_port: 22
        to_port: 22
        cidr_ip: '0.0.0.0/0'
      - proto: icmp
        from_port: 8
        to_port: -1
        cidr_ip: '0.0.0.0/0'
    rules_outbound:
      - proto: -1
        from_port: 0
        to_port: 0
        cidr_ip: '0.0.0.0/0'
~~~

Dependencies
------------

Environment Variables:
`AWS_SECRET_ACCESS_KEY` (or IAM policy)
`AWS_ACCESS_KEY_ID` (or IAM policy)
`AWS_DEFAULT_REGION`

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables
passed in as parameters) is always nice for users too:

~~~yml
---
- hosts: localhost
  connection: local
  environment:
    AWS_SECRET_ACCESS_KEY: abcd123456
    AWS_ACCESS_KEY_ID: abcd123456
    AWS_DEFAULT_REGION: us-gov-west-1 # Optional. Also can be defined in group_vars/all/ec2-vpc.yml
  roles:
    - role: ec2-sg
~~~

License
-------

BSD

Author Information
------------------

Chris Kuperstein <ckuperst@redhat.com>
