#!/bin/bash

#s3 bucket name
s3_bucket='s3c3ms'

#directory to download data to
data_dir='/data'

sudo rm -fr ${data_dir}/*
sudo chmod -R 777 ${data_dir}
sudo chown ec2-user:ec2-user ${data_dir}

for i in {a..z}
do
  aws s3 cp s3://${s3_bucket}/c3ms-a$i ${data_dir}
done

for i in {a..b}
do
  aws s3 cp s3://${s3_bucket}/c3ms-b$i ${data_dir}
done

for i in {a..d}
do
  aws s3 cp s3://${s3_bucket}/satellite-a$i ${data_dir}
done

echo "Combining c3ms tar files..."
cat ${data_dir}/c3ms-* > ${data_dir}/c3ms.tar

echo "Combinging Satellite tar files..."
cat ${data_dir}/satellite-* > ${data_dir}/satellite.tar

tar -xvf ${data_dir}/c3ms.tar -C ${data_dir}

tar -xvf ${data_dir}/satellite.tar -C ${data_dir}

#rm -fr ${data_dir}/c3ms*

#rm -fr ${data_dir}/satellite*

mkdir ${data_dir}/repos

mv ${data_dir}/*rpms ${data_dir}/repos

sudo rpm --install ${data_dir}/repos/rhel-7-server-rpms/Packages/d/deltarpm-3.6-3.el7.x86_64.rpm
sudo rpm --install ${data_dir}/repos/rhel-7-server-rpms/Packages/p/python-deltarpm-3.6-3.el7.x86_64.rpm
sudo rpm --install ${data_dir}/repos/rhel-7-server-rpms/Packages/c/createrepo-0.9.9-28.el7.noarch.rpm

for i in $(ls ${data_dir}/repos | grep rpms)
do
  createrepo -v ${data_dir}/repos/$i/ -g ${data_dir}/repos/$i/comps.xml
done

cat << EOF > redhat-local.repo
[rhel-7-server-rpms]
baseurl = file://${data_dir}/repos/rhel-7-server-rpms
name = Red Hat Enterprise Linux 7 Server (RPMs)
enabled = 1
gpgcheck = 0

[rhel-7-server-extras-rpms]
baseurl = file://${data_dir}/repos/rhel-7-server-extras-rpms
name = Red Hat Enterprise Linux 7 Server - Extras (RPMs)
enabled = 1
gpgcheck = 0

[rhel-7-server-ansible-2.9-rpms]
baseurl = file://${data_dir}/repos/rhel-7-server-ansible-2.9-rpms
name = Red Hat Ansible Engine 2.9 for RHEL 7 x86_64
enabled = 1
gpgcheck = 0

[rhel-server-rhscl-7-rpms]
baseurl = file://${data_dir}/repos/rhel-server-rhscl-7-rpms
name = Red Hat Software Collections (for RHEL Server)
enabled = 1
gpgcheck = 0

[rhel-7-server-ose-3.11-rpms]
baseurl = file://${data_dir}/repos/rhel-7-server-ose-3.11-rpms
name = Red Hat OpenShift Container Platform 3.11 x86_64
enabled = 1
gpgcheck = 0
EOF

sudo mv redhat-local.repo /etc/yum.repos.d/redhat-local.repo

sudo yum -y install ansible
sudo yum -y update