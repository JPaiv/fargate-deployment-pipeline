
terraform {
  backend "s3" {
    bucket         = "test.terraform.state.config.fi.bucket"
    key            = "test/state/shared-infra" # Format: ENVIRONMENT/state/PROJECT
    region         = "eu-west-1"
    dynamodb_table = "terraform-lock"
  }
}

provider "aws" {
  region = var.default_region
  #   profile = "default"

  default_tags {
    tags = {
      Environment = var.environment
      Terraform   = "true"
      Timestamp   = timestamp()
    }
  }
}

module "vp" {
  source = "../modules/vpc"
}

module "ecr" {
  source      = "../modules/ecr"
  environment = var.environment
}
