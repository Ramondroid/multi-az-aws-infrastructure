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
