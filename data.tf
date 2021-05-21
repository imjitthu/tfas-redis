terraform {
  backend "s3" {
    bucket = "terraform-state-jithendar"
    key    = "rs-instances/redis.tfstate"
    region = "us-east-1"
  }
}