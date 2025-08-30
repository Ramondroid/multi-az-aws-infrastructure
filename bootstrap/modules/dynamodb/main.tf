resource "aws_dynamodb_table" "tf_lock" {
    name = var.dynamodb_table_name
    billing_mode = var.billing_mode
    hash_key = var.hash_key

    attribute {
        name = var.attribute_config.name
        type = var.attribute_config.type
    }

    server_side_encryption {
        enabled = var.sse_enabled
    }
    tags = var.project_code
}