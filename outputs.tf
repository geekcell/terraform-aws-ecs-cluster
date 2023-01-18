output "name" {
  description = "The name of the ECS cluster."
  value       = aws_ecs_cluster.main.name
}

output "arn" {
  description = "The ARN of the ECS cluster."
  value       = aws_ecs_cluster.main.arn
}
