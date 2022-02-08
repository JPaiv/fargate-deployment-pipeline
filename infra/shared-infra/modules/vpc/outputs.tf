output "main_vpc_id" {
  value = aws_vpc.main.id
}

output "private_subnet_ids" {
  value = [for subnet in aws_subnet.private : subnet.id]
}

output "public_subnet_ids" {
  value = [for subnet in aws_subnet.public : subnet.id]
}

output "alb_security_group_id" {
  value = aws_security_group.alb_security_group.id
}

output "main_alb_target_group_arn" {
 value = aws_alb_target_group.main_alb_target_group.arn
 }