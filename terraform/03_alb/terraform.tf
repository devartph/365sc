terraform {
  required_version = ">= 0.13.0"

  backend "s3" {
    bucket          = "365sc-terraform-backend"
    key             = "sandbox/global/alb/terraform.tfstate"
    region          = "us-west-2"

    dynamodb_table  = "terraform-lock"
    encrypt         = "true"
  }
}
