## NAMING
variable "name" {
  description = "Name of the ECS cluster."
  type        = string
}

variable "tags" {
  description = "Tags to add to the ECS cluster."
  default     = {}
  type        = map(any)
}

## CLUSTER
variable "enable_container_insights" {
  description = "Enable CloudWatch Container Insights for the cluster."
  default     = true
  type        = bool
}

variable "encrypt_execute_command_session" {
  description = "Encrypt execute command session for the cluster."
  default     = true
  type        = bool
}

variable "logging_execute_command_session" {
  description = "DEFAULT"
  default     = false
  type        = bool
}
