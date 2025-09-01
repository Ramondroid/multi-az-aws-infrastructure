terraform {
  backend "s3" {
    bucket         = "multi-az-s3-bucket-project"
    key            = "global/terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "multi-az-dynamodb-table"
    encrypt        = true
  }
}