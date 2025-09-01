output "bastion_ip" {
  description = "The public IP address of the Bastion host"
  value       = aws_instance.bastion.public_ip
}