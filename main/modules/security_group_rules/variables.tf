
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