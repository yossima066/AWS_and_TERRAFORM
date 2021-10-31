resource "aws_instance" "DB_instance" {
  count                       = var.instance_to_create
  ami                         = data.aws_ami.ubuntu-18.id
  instance_type               = var.instance_type
  availability_zone           = var.available_zone_names[count.index]
  key_name                    = var.key_name
  subnet_id                   = var.private_subnet_ids[count.index]
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.ssh_access.id, aws_security_group.outbound_anywhere.id]

  tags = {
    "Name" = "DB-${count.index}"
  }
}



