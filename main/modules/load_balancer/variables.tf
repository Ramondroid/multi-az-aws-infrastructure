variable "load_balancer_type" {
  description = "Type of the load balancer (application, network, gateway)"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where the load balancer and target group will be created"
  type        = string
}

variable "frontend_internal" {
  description = "Boolean to specify if the load balancer is internal or internet-facing"
  type        = bool
  default     = false
}

variable "backend_internal" {
  description = "Boolean to specify if the target group is internal or internet-facing"
  type        = bool
  default     = true
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for the load balancer"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for the target group"
  type        = list(string)
  
}

variable "frontend_alb_tg_config" {
  description = "Configuration for the frontend ALB target group"
  type = object({
    port     = number 
    protocol = string
    target_type = string
    action = string
  })
}

variable "backend_alb_tg_config" {
  description = "Configuration for the frontend ALB target group"
  type = object({
    port     = number 
    protocol = string
    target_type = string
    action = string
  })
}

variable "frontend_alb_health_check_config" {
  description = "Health check configuration for the frontend ALB target group"
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

variable "backend_alb_health_check_config" {
  description = "Health check configuration for the frontend ALB target group"
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
  description = "The project code for tagging resources"
  type        = map(string)
}