output "lock_table_name" {
    value = aws_dynamodb_table.tf_lock.id
}