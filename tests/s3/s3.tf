terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

module "s3" {
  source = "../../modules/s3"

  coralogix_region   = "Europe"
  ssm_enable         = "false"
  private_key        = "${{ secrets.TESTING_PRIVATE_KEY }}"
  layer_arn          = "arn:aws:lambda:us-east-1:035955823196:layer:coralogix-ssmlayer:1"
  application_name   = "s3"
  subsystem_name     = "logs"
  s3_bucket_name     = "github-action-bucket-testing"
  integration_type   = "s3"
}
