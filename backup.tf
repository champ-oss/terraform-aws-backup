resource "aws_backup_vault" "this" {
  count         = var.enabled ? 1 : 0
  name          = local.name
  force_destroy = !var.protect
  kms_key_arn   = var.kms_key_arn
  tags          = merge(local.tags, var.tags)
}

resource "aws_backup_vault_lock_configuration" "this" {
  count               = var.enabled && var.enable_vault_lock ? 1 : 0
  backup_vault_name   = aws_backup_vault.this[0].name
  changeable_for_days = var.lock_changeable_for_days
  max_retention_days  = var.lock_max_retention_days
  min_retention_days  = var.lock_min_retention_days
}

resource "aws_backup_plan" "this" {
  count = var.enabled ? 1 : 0
  name  = local.name
  tags  = merge(local.tags, var.tags)

  rule {
    rule_name                    = local.name
    target_vault_name            = aws_backup_vault.this[0].name
    schedule                     = var.schedule
    schedule_expression_timezone = var.schedule_expression_timezone
    enable_continuous_backup     = var.enable_continuous_backup
    start_window                 = var.start_window
    completion_window            = var.completion_window
    recovery_point_tags          = merge(local.tags, var.tags)

    lifecycle {
      cold_storage_after                        = var.cold_storage_after
      delete_after                              = var.delete_after
      opt_in_to_archive_for_supported_resources = var.opt_in_to_archive_for_supported_resources
    }

    dynamic "copy_action" {
      for_each = var.enable_copy ? [1] : []
      content {
        destination_vault_arn = var.destination_vault_arn
        lifecycle {
          cold_storage_after                        = var.cold_storage_after
          delete_after                              = var.delete_after
          opt_in_to_archive_for_supported_resources = var.opt_in_to_archive_for_supported_resources
        }
      }
    }
  }
}

resource "aws_backup_selection" "this" {
  count        = var.enabled ? 1 : 0
  iam_role_arn = aws_iam_role.this[0].arn
  name         = local.name
  plan_id      = aws_backup_plan.this[0].id
  resources    = [var.resource_arn]
}