resource "random_password" "aurora_master_password" {
  length           = 24
  special          = true
  override_special = "!#$%^*()-=+_?{}|"
}

resource "aws_ssm_parameter" "ssm_aurora_master_username" {
  name  = "${var.environment}-aurora_master_username"
  type  = "SecureString"
  value = var.aurora_master_username
}

resource "aws_ssm_parameter" "ssm_aurora_master_password" {
  name  = "${var.environment}-aurora_master_password"
  type  = "SecureString"
  value = random_password.aurora_master_password.result
}
