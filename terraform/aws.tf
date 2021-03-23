provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region
}

resource "aws_vpc" "terraform-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_subnet" "public-1" {
  vpc_id                  = aws_vpc.terraform-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = var.aws_availability_region
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.terraform-vpc.id
}

resource "aws_route_table" "rt1" {
  vpc_id = aws_vpc.terraform-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "association-subnet" {
  subnet_id      = aws_subnet.public-1.id
  route_table_id = aws_route_table.rt1.id
}

resource "aws_security_group" "web_nodes" {
  name        = "web"
  vpc_id      = aws_vpc.terraform-vpc.id
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

resource "aws_instance" "aws_web_nodes" {
  count                  = var.aws_web_count
  ami                    = var.aws_ami_id
  instance_type          = var.aws_instance_type
  key_name               = var.aws_key_name
  vpc_security_group_ids = [ aws_security_group.web_nodes.id ]
  subnet_id              = aws_subnet.public-1.id
  tags = {
    Name = format("web-%02d", count.index + 1)
  }
  user_data = file("scripts/firstboot.sh")
}
