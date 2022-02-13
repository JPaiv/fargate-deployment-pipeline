terraform {
  backend "s3" {
    bucket = "test.terraform.state.config.fi.test.bucke"
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
  environment = var.environment
}

module "ecr" {
  source      = "../modules/ecr"
  environment = var.environment
}

module "ecs" {
  source      = "../modules/ecs"
  environment = var.environment
}

module "ssm" {
  source      = "../modules/ssm"
  environment = var.environment
}

module "aurora" {
  source      = "../modules/aurora"
  environment = var.environment
  aurora_cluster_master_username = module.ssm.aurora_cluster_master_username
  aurora_cluster_master_password = module.ssm.aurora_cluster_master_password
}