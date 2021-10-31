
resource "aws_security_group" "http_acces" {
  vpc_id = var.vpc_id
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }
  tags = {
    "Name" = "http_acces"
  }

}

resource "aws_security_group" "ssh_access" {
  vpc_id = var.vpc_id
  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = "Shh_Acces"
  }

}

resource "aws_security_group" "outbound_anywhere" {
  vpc_id = var.vpc_id
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = "outbound_anywhere"
  }
}

