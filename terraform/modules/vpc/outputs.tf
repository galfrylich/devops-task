output "private_sg_id" {
    description = "private_sg_id"  
    value = aws_security_group.cka_private_sg.id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = aws_subnet.cka_public_subnets[*].id  # Using * to return all subnet IDs
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = aws_subnet.private_subnets[*].id  # Using * to return all subnet IDs
}

output "public_sg_id" {
    description = "public_sg_id"  
    value = aws_security_group.cka_public_sg.id
}

output "vpc_id" {
  value = aws_vpc.vpc-cka-gal.id
}
