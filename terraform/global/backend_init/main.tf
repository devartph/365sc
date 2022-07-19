terraform {
  required_version = ">= 0.13.0"
}

provider "aws" {
  region = var.region
}

module "tf_backend" {
  source = "git::https://github.com/DNXLabs/terraform-aws-backend?ref=2.0.0"

  bucket_prefix        = "365sc"
  bucket_sse_algorithm = "AES256"
  workspaces           = ["sandbox"]

  assume_policy = {}
}
