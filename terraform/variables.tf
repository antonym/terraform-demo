### VM Counts
variable "vcd_web_count" {
  description = "vcd web node count"
  default     = 0
}

variable "aws_web_count" {
  description = "aws web node count"
  default     = 1
}

variable "google_web_count" {
  description = "google web node count"
  default     = 1
}

### Variables
variable "vcd_user" {
  description = "vCloud user"
  sensitive   = true
}

variable "vcd_pass" {
  description = "vCloud pass"
  sensitive   = true
}

variable "vcd_org" {
  description = "vCloud org"
  sensitive   = true
}

variable "vcd_vdc" {
  description = "vCloud VDC"
  sensitive   = true
}

variable "vcd_url" {
  description = "vCloud url"
  sensitive   = true
}

variable "vcd_max_retry_timeout" {
  description = "vCloud vcd_max_retry_timeout"
  default     = 120
}

variable "vcd_allow_unverified_ssl" {
  description = "vCloud vcd_allow_unverified_ssl"
  default     = "true"
}

variable "vcd_auth_type" {
  description = "Auth type"
}

variable "vcd_catalog_name" {
  default = "Rackspace Test Images"
}

variable "vcd_template_name" {
  default = "Ubuntu 20.04 Template"
}

variable "aws_access_key" {
  description = "AWS Access key"
  sensitive   = true
}

variable "aws_secret_key" {
  description = "AWS Secret key"
  sensitive   = true
}

variable "aws_ami_id" {
  description = "AWS ami id"
  default     = "ami-08962a4068733a2b6"
}

variable "aws_region" {
  description = "aws region"
  default     = "us-east-2"
}

variable "aws_availability_region" {
  description = "aws availability region"
  default     = "us-east-2a"
}

variable "aws_instance_type" {
  description = "aws instance type"
  default     = "t2.micro"
}

variable "aws_key_name" {
  description = "aws key name"
  default     = "aws-keys"
}

variable "gce_project_id" {
  type      = string
  sensitive = true
}

variable "gce_region" {
  type      = string
  sensitive = true
}

variable "gce_zone" {
  type      = string
  sensitive = true
}

variable "gce_image_name" {
  type    = string
  default = "ubuntu-os-cloud/ubuntu-2004-lts"
}

variable "ssh_key_pub" {
  description = "public ssh key"
}

variable "ssh_port" {
  type    = string
  default = "22"
}

variable "http_port" {
  type    = string
  default = "80"
}

variable "https_port" {
  type    = string
  default = "443"
}

variable "any_port" {
  type    = string
  default = "0"
}

variable "any_protocol" {
  type    = string
  default = "-1"
}

variable "tcp_protocol" {
  type    = string
  default = "tcp"
}

variable "all_ips" {
  type    = list(any)
  default = ["0.0.0.0/0"]
}

variable "gce_ssh_user" {
  type    = string
  default = "root"
}
