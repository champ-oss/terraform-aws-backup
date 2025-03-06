module "s3" {
  source  = "github.com/champ-oss/terraform-aws-s3.git?ref=v1.0.57-68016e0"
  git     = "terraform-aws-backup"
  name    = "example"
  protect = false
}

module "this" {
  source       = "../../"
  git          = "terraform-aws-backup"
  name         = "example"
  resource_arn = module.s3.arn
  protect      = false
  delete_after = 30
}