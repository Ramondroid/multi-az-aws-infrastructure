variable "load_balancer_type" {
  description = "Type of the load balancer (application, network, gateway)"
  type        = string
}
variable "vpc_id" {
  description = "The VPC ID where the load balancer and target group will be created"
  type        = string
}
variable "public_subnet_ids" {
  description = "List of public subnet IDs for the load balancer"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for the load balancer"
  type        = list(string)

}
variable "load_balancer_config" {
  description = "Configuration for the Load Balancer"
  type = object({
    internal    = bool
    name        = string
    port        = number
    protocol    = string
    target_type = string
    action      = string
  })
}
variable "health_check_config" {
  description = "Health check configuration for the ALB target group"
  type = object({
    path                = string
    protocol            = string
    matcher             = string
    interval            = number
    timeout             = number
    healthy_threshold   = number
    unhealthy_threshold = number
  })
}
variable "project_code" {
  description = "A map containing project code details"
  type        = map(string)
}