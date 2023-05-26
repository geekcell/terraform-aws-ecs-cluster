output "name" {
  description = "The name of the ECS cluster."
  value       = module.basic-example.name
}

output "arn" {
  description = "The ARN of the ECS cluster."
  value       = module.basic-example.arn
}

output "command_session_kms_arn" {
  description = "The ARN of the KMS key used to encrypt the command session."
  value       = try(module.basic-example.command_session_kms_arn, null)
}

output "command_session_cloudwatch_log_group_arn" {
  description = "The ARN of the CloudWatch log group used to store the command session."
  value       = try(module.basic-example.command_session_cloudwatch_log_group_arn, null)
}
