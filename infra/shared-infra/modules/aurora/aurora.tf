resource "aws_rds_cluster" "main" {
  cluster_identifier      = "${var.environment}-aurora-serverless-cluster"
  engine                  = "aurora-mysql"
  engine_mode             = "serverless"  
  database_name           = "${var.environment}MovieDatabase"
  enable_http_endpoint    = true  
  master_username         = var.aurora_master_username
  master_password         = var.aurora_master_password
  apply_immediately = true
  backup_retention_period = 1
  
  skip_final_snapshot     = true
  
  scaling_configuration {
    auto_pause               = true
    min_capacity             = 1    
    max_capacity             = 2
    seconds_until_auto_pause = 300
    timeout_action           = "ForceApplyCapacityChange"
  }  
}