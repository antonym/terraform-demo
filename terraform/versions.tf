terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.45.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "3.71.0"
    }
    vcd = {
      source  = "vmware/vcd"
      version = "3.5.1"
    }
  }
  backend "remote" {
    organization = "racklabs"

    workspaces {
      name = "terraform-demo"
    }
  }
}
