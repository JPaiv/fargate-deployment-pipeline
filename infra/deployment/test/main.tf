data "terraform_remote_state" "shared_infra" {
  backend = "s3"
  config = {
    bucket = "test.terraform.state.config.fi.test.bucke"
    key    = "test/state/shared-infra-config" # Format: ENVIRONMENT/state/PROJECT
    region = "eu-west-1"
  }
}

terraform {
  backend "s3" {
    bucket = "test.terraform.state.config.fi.test.bucke"
    key    = "test/state/application" # Format: ENVIRONMENT/state/PROJECT
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
  source            = "../modules/application"
  main_vpc_id       = data.terraform_remote_state.shared_infra.output.main_vpc_id
  public_subnet_ids  = data.terraform_remote_state.shared_infra.outputs.public_subnet_ids
  private_subnet_ids = data.terraform_remote_state.shared_infra.outputs.private_subnet_ids
  repository_url = data.terraform_remote_state.shared_infra.outputs.repository_url
  alb_security_group_id = data.terraform_remote_state.shared_infra.outputs.alb_security_group_id
  cluster_id = data.terraform_remote_state.shared_infra.outputs.cluster_id
  main_alb_target_group_arn = data.terraform_remote_state.shared_infra.outputs.main_alb_target_group_arn
  environment       = var.environment
  app_image         = var.image_tag
}
