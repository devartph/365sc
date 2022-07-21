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