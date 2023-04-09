# Create a new S3 bucket to store the state file
resource "aws_s3_bucket" "s3_bucket_tf_remote_state" {
  bucket              = var.s3_bucket_name
  force_destroy       = var.s3_force_destroy
  object_lock_enabled = var.s3_object_lock_enabled

  lifecycle {
    create_before_destroy = true
  }
 
  tags = merge({
    Name = var.s3_bucket_name
  }, var.tags)
}

resource "aws_s3_bucket_versioning" "s3_bucket_tf_remote_state_versioning" {
  bucket = aws_s3_bucket.s3_bucket_tf_remote_state.id
  
  versioning_configuration {
    status = var.s3_versioning
  }
}

resource "aws_s3_bucket_acl" "s3_bucket_acl_tf_remote_state" {
  bucket = aws_s3_bucket.s3_bucket_tf_remote_state.id
  acl    = "private"
}

resource "aws_kms_key" "kms_key_s3_bucket_tf_remote_state" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = var.kms_key_deletion_window
  enable_key_rotation     = var.kms_key_enable_key_rotation
  multi_region            = var.kms_key_multi_region
  tags                    = var.tags
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3_bucket_sse_configuration" {
  bucket = aws_s3_bucket.s3_bucket_tf_remote_state.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.kms_key_s3_bucket_tf_remote_state.arn
      sse_algorithm     = var.sse_algorithm
    }
  }
}

resource "aws_s3_bucket_public_access_block" "s3_block_public_access" {
  bucket = aws_s3_bucket.s3_bucket_tf_remote_state.id
  block_public_acls       = var.s3_block_public_acls
  block_public_policy     = var.s3_block_public_policy
  ignore_public_acls      = var.s3_ignore_public_acls
  restrict_public_buckets = var.s3_restrict_public_buckets
}

# Create a new DynamoDB table to store the state lock
resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = var.dynamodb_table_name
  billing_mode   = var.dynamodb_billing_mode
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = merge({
    Name = var.dynamodb_table_name
  }, var.tags)
}