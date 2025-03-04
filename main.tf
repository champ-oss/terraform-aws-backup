locals {
  tags = {
    git     = var.git
    cost    = "shared"
    creator = "terraform"
  }

  trimmed_name = substr("${var.git}-${var.name}", 0, 44)
  name         = try("${local.trimmed_name}-${random_id.this[0].hex}", local.trimmed_name)
}

data "aws_region" "this" {}

resource "random_id" "this" {
  count       = var.enabled ? 1 : 0
  byte_length = 3
}
