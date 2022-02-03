data "terraform_remote_state" "shared_infra" {
  backend = "s3"
  config = {
    bucket = "test.terraform.state.config.fi.bucket"
    key    = "test/state/shared-infra" # Format: ENVIRONMENT/state/PROJECT
    region = "eu-west-1"
  }
}

terraform {
  backend "s3" {
    bucket = "test.terraform.state.config.fi.bucket"
    key    = "test/state/deployment" # Format: ENVIRONMENT/state/PROJECT
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

module "fargate" {
  source            = "../modules/fargate"
  main_vpc_id       = data.terraform_remote_state.shared_infra.outputs.main_vpc_id
  public_subnet_id  = data.terraform_remote_state.shared_infra.outputs.public_subnet_id
  private_subnet_id = data.terraform_remote_state.shared_infra.outputs.private_subnet_id
  environment       = var.environment
  app_image         = "test"
}
