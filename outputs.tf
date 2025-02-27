output "aws_region" {
  description = "AWS region name"
  value       = data.aws_region.this.name
}
