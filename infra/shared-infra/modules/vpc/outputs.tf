output "main_vpc_id" {
  value = aws_vpc.main.id
}

output "private_subnet_ids" {
  value = ["${aws_subnet.privatec.*.id}"]
}

output "public_subnet_ids" {
  value = ["${aws_subnet.public.*.id}"]
}