variable "cold_storage_after" {
  description = "Specifies the number of days after creation that a recovery point is moved to cold storage"
  type        = number
  default     = null
}

variable "completion_window" {
  description = "The amount of time in minutes AWS Backup attempts a backup before canceling the job and returning an error"
  type        = number
  default     = null
}

variable "delete_after" {
  description = "Specifies the number of days after creation that a recovery point is deleted. Must be 90 days greater than cold_storage_after"
  type        = number
  default     = 30
}

variable "destination_vault_arn" {
  description = "An Amazon Resource Name (ARN) that uniquely identifies the destination backup vault for the copied backup"
  type        = string
  default     = null
}

variable "enabled" {
  description = "Set to false to prevent the module from creating any resources"
  type        = bool
  default     = true
}

variable "enable_continuous_backup" {
  description = "Enable continuous backups for supported resources"
  type        = bool
  default     = false
}

variable "enable_copy" {
  description = "Enable copying backups to another vault"
  type        = bool
  default     = false
}

variable "git" {
  description = "Exact name of your git repository"
  type        = string
}

variable "kms_key_arn" {
  description = "KMS key ARN to use for encryption"
  type        = string
  default     = null
}

variable "name" {
  type        = string
  description = "Name used to identify resources"
}

variable "opt_in_to_archive_for_supported_resources" {
  description = "This setting will instruct your backup plan to transition supported resources to archive (cold) storage tier in accordance with your lifecycle settings."
  type        = bool
  default     = null
}

variable "protect" {
  description = "Protect resources from deletion"
  default     = true
  type        = bool
}

variable "resource_arn" {
  description = "An ARN that uniquely identifies a resource to back up"
  type        = string
}

variable "schedule" {
  description = "A CRON expression specifying when AWS Backup initiates a backup job"
  type        = string
  default     = "cron(0 6 * * ? *)"
}

variable "schedule_expression_timezone" {
  description = "Timezone for the schedule expression"
  type        = string
  default     = "UTC"
}

variable "start_window" {
  description = "The amount of time in minutes before beginning a backup"
  type        = number
  default     = null
}

variable "tags" {
  description = "Map of tags to assign to resources"
  type        = map(string)
  default     = {}
}