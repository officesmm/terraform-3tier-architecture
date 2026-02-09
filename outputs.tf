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

output "redis_endpoint" {
  value = aws_elasticache_replication_group.redis.primary_endpoint_address
}

output "redis_port" {
  value = aws_elasticache_replication_group.redis.port
}
