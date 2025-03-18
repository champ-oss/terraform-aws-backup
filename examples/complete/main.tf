# Separate region for copying backups
provider "aws" {
  alias  = "usw1"
  region = "us-west-1"
}

module "s3" {
  source  = "github.com/champ-oss/terraform-aws-s3.git?ref=v1.0.57-68016e0"
  git     = "terraform-aws-backup"
  name    = "example"
  protect = false
}

module "vault" {
  source       = "github.com/champ-oss/terraform-aws-backup-vault.git?ref=v1.0.1-f31b208"
  git          = "terraform-aws-backup"
  enabled      = true
  create_vault = true
  providers = {
    aws.target = aws.usw1
  }
}

module "this" {
  source       = "../../"
  git          = "terraform-aws-backup"
  name         = "example"
  resource_arn = module.s3.arn
  protect      = false
}
