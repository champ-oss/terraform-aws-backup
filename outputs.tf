output "aws_region" {
  description = "AWS region name"
  value       = data.aws_region.this.name
}

output "default_cross_region_vault_arn" {
  description = "The ARN of the default backup vault"
  value       = nonsensitive(try(data.aws_ssm_parameters_by_path.default_cross_region_vault_arn[0].values[0], null))
}
