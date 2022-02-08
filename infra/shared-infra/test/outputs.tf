output "main_vpc_id" {
  value = module.vpc.output.main_vpc_id
  depends_on = [module.vpc]
}


output "private_subnet_ids" {
  value = module.vpc.output.private_subnet_ids
  depends_on = [module.vpc]
}


output "public_subnet_ids" {
  value = module.vpc.output.public_subnet_ids
  depends_on = [module.vpc]
}
