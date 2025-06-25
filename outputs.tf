output "aws_region" {
  description = "AWS region name"
  value       = var.enabled ? data.aws_region.this.name : ""
}
