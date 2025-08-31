variable "vpc_id" {
  description = "The ID of the VPC where the security groups will be created"
  type        = string
}

variable "security_group" {
  description = "A map of security group configurations"
  type = map(object({
    name = string
  }))
}

variable "project_code" {
  description = "A map containing project code details"
  type        = map(string)
}

variable "ingress_rules" {
  type = list(object({
    description       = string
    from_port         = number
    to_port           = number
    protocol          = string
    source_sg_id      = optional(string)
    cidr_block        = optional(string)
    security_group_id = string
  }))
}

variable "egress_rules" {
  type = list(object({
    description       = string
    from_port         = number
    to_port           = number
    protocol          = string
    source_sg_id      = optional(string)
    cidr_block        = optional(string)
    security_group_id = string
  }))
}