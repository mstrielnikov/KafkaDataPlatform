# DynamoDB config variables
variable "dynamodb_table_name" {
    type = string
    default = "dynamodb-tf-state-lock-table"
}

variable "dynamodb_billing_mode" {
    type = string
    default = "PAY_PER_REQUEST"
}

# S3 config variables
variable "s3_bucket_name" {
    type    = string
    default = "s3-bucket-tf-state"    
}

variable "s3_force_destroy" {
    type = bool
    default = false
}

variable "s3_versioning" {
    type    = string
    default = "Enabled"
}

variable "s3_object_lock_enabled" {
    type = bool
    default = false
}

variable "s3_block_public_acls" {
    type = bool
    default = true
}

variable "s3_block_public_policy" {
    type = bool
    default = true
}

variable "s3_ignore_public_acls" {
    type = bool
    default = true
}

variable "s3_restrict_public_buckets" {
    type = bool
    default = true
}

variable "sse_algorithm"{
    type = string
    default = "aws:kms"
}

variable "kms_key_deletion_window" {
    description = "Waiting period, specified in number of days"
    type = number
    default = 10
}

variable "kms_key_multi_region" {
    type = bool
    default = false
}

variable "kms_key_enable_key_rotation" {
    type = bool
    default = false
}

variable "multi_region" {
    type = bool
    default = false
}

variable "tags" {
    type = map
    default = {}
}