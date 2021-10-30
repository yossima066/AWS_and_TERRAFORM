resource "aws_instance" "DB_instance" {
  count                       = var.DB_instances_count
  ami                         = data.aws_ami.ubuntu-18.id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.private.*.id[count.index]
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.DB_instance_access.id]

  tags = {
    "Name" = "DB-${regex(".$", data.aws_availability_zones.available.names[count.index])}"
  }
}

################

resource "aws_security_group" "DB_instance_access" {
  vpc_id = aws_vpc.Whiskeyword.id
  name   = "DB-access"

  tags = {
    "Name" = "DB-access-${aws_vpc.Whiskeyword.id}"
  }
}

resource "aws_security_group_rule" "DB_ssh_access" {
  description       = "allow ssh access from anywhere"
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.DB_instance_access.id
  to_port           = 22
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "DB_outbound_anywhere" {
  description       = "allow outbound traffic to anywhere"
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.DB_instance_access.id
  to_port           = 0
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}
