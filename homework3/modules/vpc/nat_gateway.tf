resource "aws_nat_gateway" "nat" {
  count         = length(aws_subnet.private)
  allocation_id = aws_eip.eip.*.id[count.index]
  subnet_id     = aws_subnet.public.*.id[count.index]

  tags = {
    "Name" = "Private_Nat_${count.index}"
  }
}
