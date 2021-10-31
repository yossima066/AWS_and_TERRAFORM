resource "aws_route_table" "route_table" {
  count  = length(var.route_tables_names)
  vpc_id = aws_vpc.vpc.id

  tags = {
    "Name" = "${var.route_tables_names[count.index]}_RTB_${aws_vpc.vpc.id}"

  }
}

resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public.*.id[count.index]
  route_table_id = aws_route_table.route_table[0].id
}

resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private.*.id[count.index]
  route_table_id = aws_route_table.route_table[count.index + 1].id
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.route_table[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route" "private" {
  count                  = length(aws_subnet.private)
  route_table_id         = aws_route_table.route_table.*.id[count.index + 1]
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.*.id[count.index]
}
