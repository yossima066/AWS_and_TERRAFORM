resource "aws_instance" "nginx" {
  count                       = var.instance_to_create
  ami                         = data.aws_ami.ubuntu-18.id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = var.public_subnet_ids[count.index]
  availability_zone           = var.available_zone_names[count.index]
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.http_acces.id, aws_security_group.ssh_access.id, aws_security_group.outbound_anywhere.id]
  user_data                   = local.my-nginx

  tags = {
    "Name" = "nginx-web-${count.index}"
  }
}

