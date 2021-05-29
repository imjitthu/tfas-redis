resource "aws_elasticache_parameter_group" "redis" {
  name        = "redis-cluster-parameter-group-${var.env}-roboshop"
  family      = "redis5.0"
  description = "Redis default cluster parameter group"
}

resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "redis-${var.env}-roboshop"
  engine               = "redis"
  node_type            = "cache.t3.small"
  num_cache_nodes      = 1
  parameter_group_name = aws_elasticache_parameter_group.redis.name
  engine_version       = "5.0.5"
  port                 = 6379
}

output "redis" {
  value = aws_elasticache_cluster.redis.cache_nodes[0].address
}

resource "aws_route53_record" "redis" {
  name        = "${var.COMPONENT}.${data.aws_route53_zone.jithendar.name}"
  type        = "CNAME"
  zone_id     = data.aws_route53_zone.jithendar.zone_id
  ttl         = "300"
  records     = [aws_elasticache_cluster.redis.cache_nodes[0].address] 
}

//records = [aws_elasticache_cluster.redis.cache_nodes[0].address]  endpoint wont be der..so using cache nodes... and cache node will have id, address, port and availability_zone information