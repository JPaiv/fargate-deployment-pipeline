output "main_vpc_id" {
  value = module.vpc.main_vpc_id
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "alb_security_group_id" {
  value = module.vpc.alb_security_group_id
}

output "main_alb_target_group_arn" {
 value = module.vpc.main_alb_target_group_arn
 }
 
 output "cluster_id" {
    value = module.ecs.cluster_id
}

output "repository_url" {
    value = module.ecr.repository_url
}

output "database_endpoint" {
    value = module.aurora.database_endpoint
}

output "database_name" {
    value = module.aurora.database_name
}

output "database_port" {
    value = module.aurora.database_port
}

output "database_arn" {
    value = module.aurora.database_arn
}