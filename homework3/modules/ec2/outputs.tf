output "db_servers_private_ips" {
  value = aws_instance.DB_instance.*.private_ip
}

output "web_servers_public_ips" {
  value = aws_instance.nginx.*.public_ip
}

output "alb_public_dns" {
  value = aws_lb.web-nginx.dns_name
}
