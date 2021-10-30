resource "aws_lb" "web-nginx" {
  name               = "nginx-alb-${aws_vpc.vpc.id}"
  internal           = false
  load_balancer_type = "application"
  subnets            = aws_subnet.public.*.id
  security_groups    = [aws_security_group.nginx_instances_access.id]
  access_logs {
    bucket  = data.aws_s3_bucket.main_bucket.bucket
    prefix  = "logs/web-nginx-lb"
    enabled = true
  }
  tags = {
    "Name" = "nginx-alb-${aws_vpc.vpc.id}"
  }
}
resource "aws_lb_cookie_stickiness_policy" "cookie" {
  name                     = "cookie-policy"
  load_balancer            = aws_elb.web-nginx.id
  lb_port                  = 80
  cookie_expiration_period = 60
}

resource "aws_lb_listener" "web-nginx" {
  load_balancer_arn = aws_lb.web-nginx.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web-nginx.arn
  }
}

resource "aws_lb_target_group" "web-nginx" {
  name     = "nginx-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id

  health_check {
    port                = 80
    protocol            = "HTTP"
    enabled             = true
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 10
  }

  tags = {
    "Name" = "nginx-target-group-${aws_vpc.vpc.id}"
  }
}

resource "aws_lb_target_group_attachment" "web_server" {
  count            = length(aws_instance.nginx)
  target_group_arn = aws_lb_target_group.web-nginx.id
  target_id        = aws_instance.nginx.*.id[count.index]
  port             = 80
}
