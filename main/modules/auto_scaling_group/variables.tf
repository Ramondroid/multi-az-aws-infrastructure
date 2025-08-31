variable "asg_config" {
  description = "Configuration for the Auto Scaling Group"
  type = object({
    desired_capacity          = number
    max_size                  = number
    min_size                  = number
    health_check_type         = string
    health_check_grace_period = number
    name                      = string
  })
}
variable "subnet_ids" {
  description = "List of subnet IDs for the Auto Scaling Group"
  type        = list(string)
}

variable "launch_template_config" {
  description = "Configuration for the Launch Template"
  type = object({
    instance_type = string
    key_name      = string
    resource_type = string
  })
}

variable "security_group_ids" {
  description = "List of security group IDs to associate with the instances"
  type        = list(string)
}

variable "user_data" {
  description = "User data script to configure instances"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs to associate with the instances"
  type        = list(string)
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
  })

}

variable "data_most_recent" {
  description = "Boolean to fetch the most recent AMI"
  type        = bool
}

variable "project_code" {
  description = "A map containing project code details"
  type        = map(string)
}
