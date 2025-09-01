output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.vpc.id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = [for subnet in aws_subnet.public_subnet : subnet.id]
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = [for subnet in aws_subnet.private_subnet : subnet.id]
}

output "private_subnet_frontend_asg_ids" {
  description = "List of private subnet IDs for the Frontend ASG"
  value       = slice(values(aws_subnet.private_subnet)[*].id, 0, 2)
}

output "private_subnet_backend_asg_ids" {
  description = "List of private subnet IDs for the Frontend ASG"
  value       = slice(values(aws_subnet.private_subnet)[*].id, 2, 4)
}