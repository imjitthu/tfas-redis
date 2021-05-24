terraform {
  backend "s3" {
    bucket = "terraform-state-rs-practice"
    key    = "rs-instances/redis.tfstate"
    region = "us-east-1"
  }
}