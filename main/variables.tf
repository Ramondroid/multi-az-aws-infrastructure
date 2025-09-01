variable "project_code" {
  description = "A map containing project code details"
  type        = map(string)
}

variable "public_subnets" {
  description = "Map of public subnets with their CIDR blocks and availability zones"
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
}

variable "private_subnets" {
  description = "Map of private subnets with their CIDR blocks and availability zones"
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
}

variable "map_public_ip_on_launch" {
  description = "Boolean to enable/disable public IP mapping on launch"
  type        = bool
}

variable "vpc_config" {
  description = "Configuration for the VPC"
  type = object({
    cidr_block           = string
    enable_dns_support   = bool
    enable_dns_hostnames = bool
  })
}

variable "domain_type" {
  description = "Domain type for the EIP (vpc or standard)"
  type        = string
}

variable "security_group" {
  description = "Map of security groups"
  type = map(object({
    name = string
  }))
}

variable "SSH_port" {
  description = "Port for SSH access"
  type        = number

}

variable "HTTP_port" {
  description = "Port for HTTP access"
  type        = number
}

variable "TCP_protocol" {
  description = "Protocol type for TCP"
  type        = string
}

variable "Any_cidr" {
  description = "CIDR block for allowing access from any IP"
  type        = string
}

variable "Any_protocol" {
  description = "Protocol type for allowing access from any protocol"
  type        = string
}

variable "Any_port" {
  description = "Port range for allowing access from all ports"
  type        = number
}

variable "bastion_config" {
  description = "Configuration for the Bastion Host"
  type = object({
    instance_type = string
    key_name      = string
  })
}
variable "data_most_recent" {
  description = "Boolean to fetch the most recent AMI"
  type        = bool
}

variable "bastion_public_enable" {
  description = "Boolean to enable/disable public IP association for the bastion host"
  type        = bool
}

variable "frontend_load_balancer_config" {
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

variable "backend_load_balancer_config" {
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

variable "load_balancer_type" {
  description = "Type of the load balancer (application, network, gateway)"
  type        = string
}

variable "frontend_asg_config" {
  description = "Configuration for the Auto Scaling Group"
  type = object({
    desired_capacity          = number
    max_size                  = number
    min_size                  = number
    health_check_type         = string
    name              = string
  })
}

variable "backend_asg_config" {
  description = "Configuration for the Auto Scaling Group"
  type = object({
    desired_capacity          = number
    max_size                  = number
    min_size                  = number
    health_check_type         = string
    name              = string
  })
}

variable "frontend_launch_template_config" {
  description = "Configuration for the Launch Template"
  type = object({
    instance_type = string
    key_name      = string
    resource_type = string
  })
}

variable "backend_launch_template_config" {
  description = "Configuration for the Launch Template"
  type = object({
    instance_type = string
    key_name      = string
    resource_type = string
  })
}

variable "scale_out_config" {
  description = "Configuration for scale-out policy"
  type = object({
    adjustment      = number
    adjustment_type = string
    cooldown        = number
  })
}

variable "scale_in_config" {
  description = "Configuration for scale-in policy"
  type = object({
    adjustment      = number
    adjustment_type = string
    cooldown        = number
  })
}

variable "cpu_high_alarm_config" {
  description = "Configuration for CPU high CloudWatch alarm"
  type = object({
    comparison_operator = string
    metric_name         = string
    namespace           = string
    statistic           = string
    threshold           = number
    evaluation_periods  = number
    period              = number
    alarm_description = string
  })
}

variable "cpu_low_alarm_config" {
  description = "Configuration for CPU low CloudWatch alarm"
  type = object({
    comparison_operator = string
    metric_name         = string
    namespace           = string
    statistic           = string
    threshold           = number
    evaluation_periods  = number
    period              = number
    alarm_description = string
  })

}
