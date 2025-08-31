variable "region" {
  description = "The AWS region to create resources in"
  type        = string
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "dynamodb_table_name" {
  description = "The name of the DynamoDB table"
  type        = string
}

variable "billing_mode" {
  description = "The billing mode for the DynamoDB table"
  type        = string
}

variable "hash_key" {
  description = "The hash key for the DynamoDB table"
  type        = string
}

variable "attribute_config" {
  description = "Configuration for the attribute of the DynamoDB table"
  type = object({
    name = string
    type = string
  })
}

variable "project_code" {
  description = "The project code for tagging resources"
  type        = map(string)
}

variable "prevent_destroy" {
  description = "Boolean value"
  type        = bool
}

variable "force_destroy" {
  description = "Boolean value"
  type        = bool
}