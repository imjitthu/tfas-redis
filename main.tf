# resource "aws_elasticache_subnet_group" "redis" {
#   name       = "redis-${var.ENV}"
#   subnet_ids = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNETS
# }

resource "aws_elasticache_parameter_group" "redis" {
  name        = "redis-cluster-pg-roboshop"
  family      = "redis5.0"
  description = "Redis default cluster parameter group"
}

resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "redis-roboshop"
  engine               = "redis"
  node_type            = "cache.t3.small"
  num_cache_nodes      = 1
  parameter_group_name = aws_elasticache_parameter_group.redis.name
  engine_version       = "5.0.5"
  port                 = 6379
  #subnet_group_name    = aws_elasticache_subnet_group.redis.name
  #security_group_ids   = [aws_security_group.allow_redis.id]
}
# resource "aws_security_group" "allow_redis" {
#   name          = "allow-redis-${var.ENV}"
#   description   = "allow-redis-${var.ENV}"
#   vpc_id        = data.terraform_remote_state.vpc.outputs.VPC_ID
#   ingress {
#     description = "SSH"
#     from_port   = 6379
#     to_port     = 6379
#     protocol    = "tcp"
#     cidr_blocks = [data.terraform_remote_state.vpc.outputs.VPC_CIDR]
#   }
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   tags          = {
#     Name        = "allow-redis-${var.ENV}"
#   }
# }

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