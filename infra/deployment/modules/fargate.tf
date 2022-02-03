terraform {
  backend "s3" {
    bucket         = "terraform.test.nettix-aws.com"
    key            = "test/state/fargate" # Format: ENVIRONMENT/state/PROJECT
    region         = "eu-west-1"
    dynamodb_table = "terraform-lock"
  }
}

provider "aws" {
  region = "eu-west-1"

  default_tags {
    tags = {
      Environment = var.environment
      Terraform   = "true"
      Timestamp   = timestamp()
    }
  }
}
