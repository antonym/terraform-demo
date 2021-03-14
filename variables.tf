variable "vcd_user" {
  description = "vCloud user"
}

variable "vcd_pass" {
  description = "vCloud pass"
}

variable "vcd_org" {
  description = "vCloud org"
}

variable "vcd_vdc" {
  description = "vCloud VDC"
}

variable "vcd_url" {
  description = "vCloud url"
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

variable "web_count" {
  default = 2
}

variable "db_count" {
  default = 1
}

variable "ssh_key_pub" {
  description = "public ssh key"
}

variable "catalog_name" {
  default = "Rackspace Test Images"
}

variable "template_name" {
  default = "Ubuntu 20.04 Template"
}
