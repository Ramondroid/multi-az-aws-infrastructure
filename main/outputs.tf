output "public_ip" {
  description = "The public IP address of the bastion host"
  value       = module.bastion_host.bastion_ip
}

output "dns" {
    description = "The DNS name of the Application Load Balancer"
    value       = module.frontend_alb.alb_dns
}