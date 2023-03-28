terraform {
  required_version = ">= 0.14.5"

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 4.50.0"
    }

    tls = {
      source = "hashicorp/tls"
      version = ">= 4.0.4"
    }
  }

  backend "s3" {
    region         = "us-east-1"
    dynamodb_table = "dynamodb-tf-state-lock-table"
    bucket         = "tf-state"
    key            = "tf.state"
    
    encrypt = true
  }
}

provider "aws" {
  profile    = "default"
  region     = "us-east-1"
}

provider "tls" {}

module "terraform_state" {
  source = "./modules/tf-state"
  dynamodb_table_name = "dynamodb-tf-state-lock-table"
  s3_bucket_name      = "tf-state"
  tags                = var.default_tags
}

