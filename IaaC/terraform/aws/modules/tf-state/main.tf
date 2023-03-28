# Create a new S3 bucket to store the state file
resource "aws_s3_bucket" "terraform_state" {
  bucket        = var.s3_bucket_name
  acl           = "private"
  force_destroy = var.force_destroy

  versioning {
    enabled = var.s3_versioning_enabled
  }

  
  lifecycle {
    /* prevent_destroy = var.force_destroy  # Prevent accidental deletion of this S3 bucket */
    crate_before_destroy = var.create_before_destroy
  }

  object_lock_configuration {
   object_lock_enabled = var.s3_object_lock_enabled
  }
   
  # logging {
  #   target_bucket = aws_s3_bucket.s3_bucket_logging.id
  #   target_prefix = "log/"
  # }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
    }
  }

  tags = merge(
    {
        Name = var.s3_bucket_name
    }, var.tags)
}

resource "aws_s3_bucket_public_access_block" "s3_block_public_access" {
  bucket = aws_s3_bucket.s3_bucket_tf_state.id
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

  tags = merge(
    {
        Name = var.dynamodb_table_name
    }, var.tags)
}