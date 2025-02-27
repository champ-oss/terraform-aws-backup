resource "aws_s3_bucket" "this" {
  bucket_prefix = "terraform-aws-backup-"
  force_destroy = true
}

module "this" {
  source       = "../../"
  git          = "terraform-aws-backup"
  name         = "example"
  resource_arn = aws_s3_bucket.this.arn
  protect      = false
  delete_after = 3
}