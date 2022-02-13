output "aurora_cluster_master_username" {
    value = random_pet.aurora_cluster_master_username.result
}

output "aurora_cluster_master_password" {
    value = random_password.aurora_cluster_master_password.result
}