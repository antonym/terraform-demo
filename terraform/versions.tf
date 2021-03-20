terraform {
  required_providers {
    vcd = {
      source  = "vmware/vcd"
      version = "3.2.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "3.32.0"
    }
  }
  backend "remote" {
    organization = "racklabs"

    workspaces {
      name = "terraform-demo"
    }
  }
}
