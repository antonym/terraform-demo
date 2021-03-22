#!/bin/bash

if [ -e /usr/bin/apt ] ; then apt -qq update && apt install -y git ansible python3-pip; fi
if [ -e /usr/bin/yum ] ; then yum -y update && yum install -y git ansible python3-pip; fi
if [ -e /usr/bin/dnf ] ; then dnf -y update ; dnf install -y git ansible python3-pip; fi
pip3 install docker
git clone https://github.com/racklabs/terraform-demo /opt/terraform-demo
cd /opt/terraform-demo/ansible
export ANSIBLE_LOG_PATH=/var/log/ansible.log
ansible-playbook -i localhost site.yml
