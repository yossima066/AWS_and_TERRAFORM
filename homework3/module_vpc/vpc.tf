resource "aws_vpc" "Whiskeyword" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "Whiskeyword"
  }
}
terraform {
  backend "s3" {
    bucket = "mymamanbucket"
    key    = "myapp/dev/terraform.tfstate"
    region = "us-east-1"
  }
}

#SUBNETS
resource "aws_subnet" "public" {
  map_public_ip_on_launch = "true"
  count                   = length(var.public_subnet)
  cidr_block              = var.public_subnet[count.index]
  vpc_id                  = aws_vpc.Whiskeyword.id
  availability_zone       = data.aws_availabilty_zone.available.name[count.index]

  tags = {
    "Name" = "Public_subnet_${regex(".$", data.aws_availabilty_zone.available.name[count.index])}_${var.aws_vpc.Whiskeyword.id}"
  }
}

resource "aws_subnet" "private" {
  count                   = length(var.private_subnet)
  cidr_block              = var.private_subnet[count.index]
  vpc_id                  = aws_vpc.Whiskeyword.id
  map_public_ip_on_launch = "false"
  availability_zone       = data.aws_availabilty_zone.available.name[count.index]

  tags = {
    "Name" = "Private_subnet_${regex(".$", data.aws_availabilty_zone.available.name[count.index])}_${var.aws_vpc.Whiskeyword.id}"
  }
}

#IGW

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.Whiskeyword.id

  tags = {
    Name = "IGW_${aws_vpc.Whiskeyword.id}"
  }
}

# EIPs (for nats)

resource "aws_eip" "eip" {
  count = length(var.public_subnet)

  tags = {
    "Name" = "NAT_elastic_ip_${regex(".$", data.aws_availabilty_zone.available.name[count.index])}_${var.aws_vpc.Whiskeyword.id}"
  }
}

#NATs

resource "aws_nat_gateway" "nat" {
  count         = length(var.public_subnet)
  allocation_id = aws_eip.eip.*.id[count.index]
  subnet_id     = aws_subnet.public.*.id[count.index]

  tags = {
    "Name" = "NAT_${regex(".$", data.aws_availabilty_zone.available.name[count.index])}_${var.aws_vpc.Whiskeyword.id}"
  }
}

#ROUTING

resource "aws_route_table" "route_table" {
  count  = length(var.route_tables_names)
  vpc_id = aws_vpc.Whiskeyword.id

  tags = {
    "Name" = "${var.route_tables_names[count.index]}_RTB_${aws_vpc.Whiskeyword.id}"

  }
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet)
  subnet_id      = aws_subnet.public.*.id[count.index]
  route_table_id = aws_route_table.route_table[0].id
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnet)
  subnet_id      = aws_subnet.private.*.id[count.index]
  route_table_id = aws_route_table.route_table[count.index + 1].id
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.route_table[0].id
  destination_cidr_block = "0.0.0.0/0"
  gatgateway_id          = aws_internet_gateway.igw.id
}

resource "aws_route" "private" {
  count                  = length(var.private_subnet)
  route_table_id         = aws_route_table.route_table.*.id[count.index + 1]
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.*.id[count.index]
}
