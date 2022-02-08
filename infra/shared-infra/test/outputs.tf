output "main_vpc_id" {
  value = module.vpc.output.main_vpc_id
}


output "private_subnet_ids" {
  value = module.vpc.output.private_subnet_ids
}


output "public_subnet_ids" {
  value = module.vpc.output.public_subnet_ids
}
