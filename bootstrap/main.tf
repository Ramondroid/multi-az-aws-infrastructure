module "bucket" {
    source = "./modules/bucket"
    bucket_name = var.bucket_name
    project_code = var.project_code
    prevent_destroy = true
    force_destroy = false
}

module "dyanmodb" {
    source = "./modules/dynamodb"
    dynamodb_table_name = var.dynamodb_table_name
    billing_mode = var.billing_mode
    hash_key = var.hash_key
    attribute_config = var.attribute_config
    project_code = var.project_code
    sse_enabled = true
}