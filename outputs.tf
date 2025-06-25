output "aws_region" {
  description = "AWS region"
  value       = var.enabled ? data.aws_region.this.name : ""
}
