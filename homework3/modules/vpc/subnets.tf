
#SUBNETS
resource "aws_subnet" "private" {
  count                   = var.availability_zones
  cidr_block              = cidrsubnet(var.cidr_block, 8, count.index)
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available.zone_ids[count.index]

  tags = {
    "Name" = "Private_subnet_${count.index}"
  }
}

resource "aws_subnet" "public" {
  map_public_ip_on_launch = true
  count                   = var.availability_zones
  cidr_block              = cidrsubnet(var.cidr_block, 8, 100 + count.index)
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = data.aws_availability_zones.available.zone_ids[count.index]



  tags = {
    "Name" = "Public_subnet_${count.index}"
  }
}

