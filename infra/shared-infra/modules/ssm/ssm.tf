resource "random_password" "aurora_cluster_master_password" {
  length           = 24
  special          = true
  override_special = "!#$%^*()-=+_?{}|"
}

resource "random_random_pet" "aurora_cluster_master_username" {
  length           = 16
  special          = true
  override_special = "!#$%^*()-=+_?{}|"
}

resource "aws_ssm_parameter" "ssm_aurora_cluster_master_password" {
  name  = "${var.environment}-aurora_cluster_master_password"
  type  = "SecureString"
  value = random_password.aurora_cluster_master_password.result
}

resource "aws_ssm_parameter" "ssm_aurora_cluster_master_username" {
  name  = "${var.environment}-aurora_cluster_master_username"
  type  = "SecureString"
  value = random_pet.aurora_cluster_master_username.result
}