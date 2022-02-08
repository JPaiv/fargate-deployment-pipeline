terraform {
  backend "s3" {
    bucket = "test.terraform.state.config.fi.bucket"
    key    = "test/state/shared-infra-config" # Format: ENVIRONMENT/state/PROJECT
    region = "eu-west-1"
    # dynamodb_table = "test-terraform-lock-shared"
  }
}

provider "aws" {
  region = var.default_region

  default_tags {
    tags = {
      Environment = var.environment
      Terraform   = "true"
      Timestamp   = timestamp()
    }
  }
}

module "vpc" {
  source = "../modules/vpc"
}

module "ecr" {
  source      = "../modules/ecr"
  environment = var.environment
}
