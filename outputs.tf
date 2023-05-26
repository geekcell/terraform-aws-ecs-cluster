output "name" {
  description = "The name of the ECS cluster."
  value       = aws_ecs_cluster.main.name
}

output "arn" {
  description = "The ARN of the ECS cluster."
  value       = aws_ecs_cluster.main.arn
}

output "command_session_kms_arn" {
  description = "The ARN of the KMS key used to encrypt the command session."
  value       = try(module.kms[0].key_arn, null)
}

output "command_session_cloudwatch_log_group_arn" {
  description = "The ARN of the CloudWatch log group used to store the command session."
  value       = try(aws_cloudwatch_log_group.main[0].arn, null)
}
