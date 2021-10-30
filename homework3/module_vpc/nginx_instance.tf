resource "aws_instance" "nginx" {
  count                       = var.nginx_instances_count
  ami                         = data.aws_ami.ubuntu-18.id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = var.subnet_public.*.id[count.index]
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.nginx_instance_acces.id]
  user_data                   = local.my-nginx

  root_block_device {
    encrypted   = false
    volume_type = var.volumes_type
    volume_size = var.nginx_root_disk_size
  }
  ebs_block_device {
    encrypted   = true
    device_name = var.nginx_encrypted_disk_device_name
    volume_type = var.volumes_type
    volume_size = var.nginx_encrypted_disk_size

  }
  tags = {
    "Name" = "nginx-web-${regex(".$", data.aws_availabilty_zone.available.names[count.index])}"
  }
}
resource "aws_security_group" "nginx_instance_acces" {
  vpc_id = aws_vpc.Whiskeyword.id
  name   = "nginx-access"

  tags = {
    "Name" = "nginx-access-${aws.vpc.whiskeyword.id}"
  }

}

resource "aws_security_group_rule" "nginx_http_acces" {
  description       = "allow http access frome anywhere"
  from_port         = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.nginx_instance_acces.id
  to_port           = 80
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "nginx_ssh_access" {
  description       = "allow ssh access frome anywhere"
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.nginx_instance_acces.id
  to_port           = 22
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "nginx_outbound_anywhere" {
  description       = "allow outbound trafic to anywhere"
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.nginx_instance_acces.id
  to_port           = 0
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}
