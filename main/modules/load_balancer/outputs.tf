output "alb_dns" {
  description = "The DNS name of the Application Load Balancer"
  value       = aws_lb.alb.dns_name
}

output "target_group_arn" {
  description = "The ARN of the ALB Target Group"
  value       = aws_lb_target_group.target_group.arn

}