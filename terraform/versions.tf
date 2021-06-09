terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.44.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "3.71.0"
    }
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "1.42.0"
    }
    vcd = {
      source  = "vmware/vcd"
      version = "3.2.0"
    }
  }
  backend "remote" {
    organization = "racklabs"

    workspaces {
      name = "terraform-demo"
    }
  }
}
