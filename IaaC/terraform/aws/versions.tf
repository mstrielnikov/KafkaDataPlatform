terraform {
  required_version = ">= 1.0.0"

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
    region         = "eu-north-1"
    dynamodb_table = "dynamodb-tf-state-lock-table"
    bucket         = "tf-state"
    key            = "tf.state"
    shared_credentials_file = "~/.aws/credentials"
    /* profile = "default" */
    encrypt = true
  }
}
