output "alb_dns" {
  value = aws_lb.this.dns_name
}

output "db_endpoint" {
  value = aws_db_instance.this.address
}
