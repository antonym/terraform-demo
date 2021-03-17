provider "vcd" {
  user                 = var.vcd_user
  password             = var.vcd_pass
  org                  = var.vcd_org
  vdc                  = var.vcd_vdc
  url                  = var.vcd_url
  auth_type            = var.vcd_auth_type
  max_retry_timeout    = var.vcd_max_retry_timeout
  allow_unverified_ssl = var.vcd_allow_unverified_ssl
}

resource "vcd_vm" "web_nodes" {
  count         = var.web_count
  name          = format("web-%02d", count.index + 1)
  catalog_name  = var.catalog_name
  template_name = var.template_name
  memory        = 4096
  cpus          = 2
  cpu_cores     = 1
  metadata = {
    local-hostname   = format("web-%02d", count.index + 1)
    role             = "web"
    env              = "staging"
    version          = "v1"
    public-keys-data = var.ssh_key_pub
  }
  guest_properties = {
    "public-keys"    = var.ssh_key_pub
    "local-hostname" = format("web-%02d", count.index + 1)
  }

  network {
    type               = "org"
    name               = "Default2"
    ip_allocation_mode = "DHCP"
    is_primary         = true
  }

  customization {
    enabled    = true
    initscript = <<-EOT
    mkdir -p /root/.ssh
    echo "${var.ssh_key_pub}" >> /root/.ssh/authorized_keys
    chmod -R go-rwx /root/.ssh
    rm /etc/resolv.conf
    echo "nameserver 1.1.1.1" > /etc/resolv.conf
    if [ -e /usr/bin/apt ] ; then apt -qq update && apt install -y git ansible; fi
    if [ -e /usr/bin/yum ] ; then yum -y update && yum install -y git ansible; fi
    if [ -e /usr/bin/dnf ] ; then dnf -y update ; dnf install -y git ansible; fi
    git clone https://github.com/antonym/terraform-demo /opt/terraform-demo
    cd /opt/terraform-demo/ansible
    ansible-playbook -i localhost site.yml
    EOT
  }

}

