resource "aws_elasticache_subnet_group" "redis" {
  name       = "${var.name}-redis-subnet-group"
  subnet_ids = values(aws_subnet.private_db)[*].id

  tags = {
    Name = "${var.name}-redis-subnet-group"
  }
}

resource "aws_elasticache_replication_group" "redis" {
  replication_group_id       = "${var.name}-redis"
  description                = "Redis for ${var.name} app"
  node_type                  = var.redis_node_type
  num_cache_clusters         = 1
  port                       = 6379
  engine                     = "redis"
  subnet_group_name          = aws_elasticache_subnet_group.redis.name
  security_group_ids         = [aws_security_group.redis.id]
  automatic_failover_enabled = false
  multi_az_enabled           = false
}
