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

variable "domain_type" {
  description = "Domain type for the EIP (vpc or standard)"
  type        = string
}

variable "vpc_config" {
  description = "Configuration for the VPC"
  type = object({
    cidr_block           = string
    enable_dns_support   = bool
    enable_dns_hostnames = bool
  })
}