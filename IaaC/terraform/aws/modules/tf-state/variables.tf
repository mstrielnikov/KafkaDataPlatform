# Common config variables
/* variable "force_destroy" {
    type = bool
    default = false
} */

variable "create_before_destroy" {
    type = bool
    default = true
}

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


variable "s3_versioning_enabled" {
    type    = bool
    default = true
}

variable "s3_object_lock_enabled" {
    type = string 
    default = "Disabled"
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

