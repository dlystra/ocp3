iam-policy
=========

A role to create AWS IAM policies and attach them to a roles

Requirements
------------

boto, boto3

An AWS account with appropriate permissions, e.g. iam:CreatePolicy

Role Variables
--------------

Example variable structure below
~~~yaml
iam_policies:
  - name: example-policy
    description: Example IAM Policy
    policy:
      Version: '2012-10-17'
      Statement:
      - Sid: 1
        Effect: Allow
        Action:
        - ec2:DescribeInstances
        Resource: "*"
    role_name: example-role
    service: ec2
~~~

Dependencies
------------

N/A

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

~~~yaml
---
- hosts: localhost
  connection: local
  gather_facts: false
  roles:
    - iam-policy
~~~

License
-------

BSD

Author Information
------------------

Chris Kuperstein <ckuperst@redhat.com>
Dino Arachchi <dino@redhat.com>
