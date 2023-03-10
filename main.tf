/**
 * # Terraform AWS ECS Cluster
 *
 * This Terraform module provides a preconfigured solution for setting up an Amazon Elastic Container Service (ECS)
 * Cluster with enabled Container Insights, logging, and advanced monitoring. With this module, you can easily launch,
 * manage, and scale your Docker containers and applications in the cloud while having complete visibility into their
 * performance and health.
 */

resource "aws_ecs_cluster" "main" {
  name = var.name

  dynamic "setting" {
    for_each = var.enable_container_insights ? [true] : []

    content {
      name  = "containerInsights"
      value = "enabled"
    }
  }

  dynamic "configuration" {
    for_each = var.encrypt_execute_command_session || var.logging_execute_command_session != "DEFAULT" ? [true] : []

    content {
      execute_command_configuration {
        kms_key_id = var.encrypt_execute_command_session ? module.kms[0].key_id : null
        logging    = var.logging_execute_command_session

        dynamic "log_configuration" {
          for_each = var.logging_execute_command_session == "OVERRIDE" ? [true] : []

          content {
            cloud_watch_encryption_enabled = false
            cloud_watch_log_group_name     = aws_cloudwatch_log_group.main[0].name
          }
        }
      }
    }
  }

  tags = var.tags
}

module "kms" {
  count = var.encrypt_execute_command_session ? 1 : 0

  source = "github.com/geekcell/terraform-aws-kms?ref=v1.0"
  alias  = "ecs/cluster/${var.name}/ssm-logs"

  tags = var.tags
}

resource "aws_cloudwatch_log_group" "main" {
  count = var.logging_execute_command_session == "OVERRIDE" ? 1 : 0

  name = "/ecs/cluster/${var.name}/ssm-logs"
  tags = var.tags
}
