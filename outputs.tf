output "redis_PIP" {
  value = aws_instance.redis.public_ip
}