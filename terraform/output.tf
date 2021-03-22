
output "aws_web_ips" {
  value = formatlist("%v", aws_instance.aws_web_nodes.*.public_ip)
}

#output "vcd_web_ips" {
#  value = formatlist("%v", vcd_vm.vcd_web_nodes.*.network.ip)
#}
