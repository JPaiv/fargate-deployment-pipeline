output "database_endpoint" {
    value = aws_rds_cluster.main.endpoint
}

output "database_name" {
    value = aws_rds_cluster.main.database_name
}

output "database_port" {
    value = aws_rds_cluster.main.database_name
}

output "database_arn" {
    value = aws_rds_cluster.main.arn
}