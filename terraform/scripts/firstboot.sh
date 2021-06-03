#!/bin/bash

function package_install {
    if [ -e /usr/bin/apt ]; then apt -qq update && apt install -y git ansible python3-pip; fi
    if [ -e /usr/bin/yum ]; then yum -y update && yum install -y git ansible python3-pip; fi
    if [ -e /usr/bin/dnf ]; then dnf -y update ; dnf install -y git ansible python3-pip; fi
}

function docker_install {
    if [ -e /usr/bin/pip3 ]; then
      pip3 install docker
    else
      package_install
      pip3 install docker
    fi
}

function repo_checkout {
    if [ ! -e /opt/terraform-demo ]; then
      git clone https://github.com/racklabs/terraform-demo /opt/terraform-demo
    else
      pushd /opt/terraform-demo
      git reset --hard
      popd
    fi
}

function run_ansible {
    cd /opt/terraform-demo/ansible
    export ANSIBLE_LOG_PATH=/var/log/ansible.log
    ansible-playbook -i localhost site.yml
}

package_install
docker_install
repo_checkout
run_ansible
