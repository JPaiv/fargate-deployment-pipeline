output "aurora_cluster_master_password" {
    value = random_password.aurora_cluster_master_password.result
}