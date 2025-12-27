output "alb_dns" {
  value = aws_lb.this.dns_name
}

output "db_endpoint" {
  value = aws_db_instance.this.address
}

output "cloudfront_domain" {
  value = aws_cloudfront_distribution.this.domain_name
}

output "cloudfront_alias" {
  value = var.cf_domain_name
}
