variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
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