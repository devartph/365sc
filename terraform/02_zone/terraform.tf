terraform {
  required_version = ">= 0.13.0"

  backend "s3" {
    bucket          = "365sc-terraform-backend"
    key             = "sandbox/global/zone/terraform.tfstate"
    region          = "us-west-2"

    dynamodb_table  = "terraform-lock"
    encrypt         = "true"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.63"
    }
  }
}