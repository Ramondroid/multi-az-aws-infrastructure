output "security_group_ids" {
  description = "List of security group IDs"
  value = { for key, sg in aws_security_group.security_group :
  key => sg.id }
}