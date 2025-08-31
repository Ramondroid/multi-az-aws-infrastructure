resource "aws_s3_bucket" "tf_state" {
  bucket        = var.bucket_name
  force_destroy = var.force_destroy

  lifecycle {
    prevent_destroy = var.prevent_destroy
  }

  tags = var.project_code
}