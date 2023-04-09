module "terraform_state" {
  source              = "./../modules/tf-state"
  dynamodb_table_name = "dynamodb-tf-state-lock-table"
  s3_bucket_name      = "tf-state"
  tags                = var.default_tags
}

