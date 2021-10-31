resource "aws_eip" "eip" {
  count = length(aws_subnet.public)

  tags = {
    "Name" = "NAT_elastic_ip_${count.index}"
  }
}
