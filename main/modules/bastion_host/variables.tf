variable "data_most_recent" {
  description = "Boolean to fetch the most recent AMI"
  type        = bool
}

variable "bastion_config" {
  description = "Configuration for the Bastion Host"
  type = object({
    instance_type = string
    key_name      = string
  })
}

variable "subnet_id" {
  description = "The subnet ID where the bastion host will be launched"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs to associate with the bastion host"
  type        = list(string)
}

variable "bastion_public_enable" {
  description = "Boolean to enable/disable public IP association for the bastion host"
  type        = bool
}