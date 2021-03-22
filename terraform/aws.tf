provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region
}

resource "aws_vpc" "aws_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_subnet" "us-east-2a-public" {
  vpc_id                  = aws_vpc.aws_vpc.id
  cidr_block              = "10.0.1.0/25"
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = true
}

resource "aws_instance" "aws_web_nodes" {
  count         = var.aws_web_count
  ami           = var.aws_ami_id
  instance_type = var.aws_instance_type
  key_name      = var.aws_key_name
  subnet_id     = aws_subnet.us-east-2a-public.id
  tags = {
    Name = format("web-%02d", count.index + 1)
  }
  user_data     = << EOF
    if [ -e /usr/bin/apt ] ; then apt -qq update && apt install -y git ansible python3-pip; fi
    if [ -e /usr/bin/yum ] ; then yum -y update && yum install -y git ansible python3-pip; fi
    if [ -e /usr/bin/dnf ] ; then dnf -y update ; dnf install -y git ansible python3-pip; fi
    pip3 install docker
    git clone https://github.com/racklabs/terraform-demo /opt/terraform-demo
    cd /opt/terraform-demo/ansible
    export ANSIBLE_LOG_PATH=/var/log/ansible.log
    ansible-playbook -i localhost site.yml
  EOF      
}

resource "aws_security_group" "web_nodes" {
  name        = "web"
  vpc_id      = aws_vpc.aws_vpc.id
  description = "Allow HTTP/HTTPS"
  tags = {
    Name = "web_nodes"
  }

  ingress {
    protocol    = var.tcp_protocol
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    cidr_blocks = var.all_ips
  }

  ingress {
    protocol    = var.tcp_protocol
    from_port   = var.http_port
    to_port     = var.http_port
    cidr_blocks = var.all_ips
  }

  ingress {
    protocol    = var.tcp_protocol
    from_port   = var.https_port
    to_port     = var.https_port
    cidr_blocks = var.all_ips
  }

  egress {
    protocol    = var.any_protocol
    from_port   = var.any_port
    to_port     = var.any_port
    cidr_blocks = var.all_ips
  }
}
