variable "INSTANCE_TYPE" {
    default = ""
}

variable "R53_ZONE_ID" {}

variable "DOMAIN" {default = ""}

variable "COMPONENT" {}
variable "AMI" {}
variable "PASSWORD" {}
variable "USER" {}
variable "REDIS_REPO" {
    default = "http://rpms.remirepo.net/enterprise/remi-release-7.rpm"
}