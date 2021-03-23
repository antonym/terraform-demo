
output "aws_web_ips" {
  value = formatlist("%v", aws_instance.aws_web_nodes.*.public_ip)
}

output "vpc-id" {
  value = aws_vpc.terraform-vpc.id
}

output "vpc-publicsubnet" {
  value = aws_subnet.public-1.cidr_block
}

output "vpc-publicsubnet-id" {
  value = aws_subnet.public-1.id
}

#output "vcd_web_ips" {
#  value = formatlist("%v", vcd_vm.vcd_web_nodes.*.network.ip)
#}
