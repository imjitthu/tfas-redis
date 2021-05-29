variable "INSTANCE_TYPE" {
    default = ""
}

variable "DOMAIN" {default = ""}

variable "COMPONENT" {}

variable "env" {}

variable "REDIS_REPO" {
    default = "http://rpms.remirepo.net/enterprise/remi-release-7.rpm"
}