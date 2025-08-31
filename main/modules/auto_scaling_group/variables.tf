variable "asg_config" {
  description = "Configuration for the Auto Scaling Group"
  type = object({
    desired_capacity     = number
    max_size             = number
    min_size             = number
    health_check_type    = string
    health_check_grace_period = number
    name                 = string
    vpc_zone_identifier  = list(string)
    launch_template_id   = string
    launch_template_version = string
  })
}

variable "launch_template_config" {
  description = "Configuration for the Launch Template"
  type = object({
    instance_type       = string
    key_name           = string
    security_group_ids  = list(string)
    user_data          = string
  })
}

variable "security_group_ids" {
  description = "List of security group IDs to associate with the instances"
  type        = list(string)
}

variable "scale_out_config" {
  description = "Configuration for scale-out policy"
  type = object({
    adjustment          = number
    adjustment_type     = string
    cooldown            = number
  })
}

variable "scale_in_config" {
  description = "Configuration for scale-in policy"
  type = object({
    adjustment          = number
    adjustment_type     = string
    cooldown            = number
  })
}

variable "cpu_high_alarm_config" {
  description = "Configuration for CPU high CloudWatch alarm"
  type = object({
    comparison_operator = string
    metric_name        = string
    namespace          = string
    statistic          = string
    threshold           = number
    evaluation_periods  = number
    period              = number
  })
}

variable "cpu_low_alarm_config" {
  description = "Configuration for CPU low CloudWatch alarm"
  type = object({
    comparison_operator = string
    metric_name        = string
    namespace          = string
    statistic          = string
    threshold           = number
    evaluation_periods  = number
    period              = number
  })
  
}

variable "data_most_recent" {
  description = "Boolean to fetch the most recent AMI"
  type        = bool
}