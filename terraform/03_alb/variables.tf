variable "health_check" {
    type = map(string)
    default = {
      "timeout"  = "10"
      "interval" = "20"
      "path"     = "/"
      "port"     = "80"
      "unhealthy_threshold" = "2"
      "healthy_threshold" = "3"
    }
}

variable "security_grp" {
    type = list
    default = ["sg-0266e2f77c1733000"]
}

variable "subnets" {
    type = list
    default = ["subnet-0f8543b50e95a2a55","subnet-09f4f5b6b327eb492"]
}

variable "subnet_nginx" {
    description = "AWS subnet for testing ALB worldwide"
    type = string
    default = "subnet-0f8543b50e95a2a55"
}

variable "vpc_id" {
  description = "AWS VPC ID"
  type        = string
  default = "vpc-0a492f221d3412d80"
}

variable "certificate_arn_nginx" {
  description = "ACM arn for ALB testing"
  type        = string
  default = "arn:aws:acm:us-west-2:780616323728:certificate/9bb2688e-e351-47d2-b515-663383e0bc2d"
}

variable "zone_id_nginx" {
  description = "AWS Route53 testing zone"
  type        = string
  default = "Z0628016K380J9ZRCU92"
}