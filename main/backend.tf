terraform {
  backend "s3" {
    bucket         = "MultiAZ-S3-Bucket"
    key            = "global/terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "MultiAZ-DynamoDB-Table"
    encrypt        = true
  }
}