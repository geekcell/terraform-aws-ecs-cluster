/**
 * # Terraform AWS ECS Cluster Module
 *
 * Module to create an AWS ECS Cluster and configure it with logging and advanced monitoring.
 */
module "kms" {
  count  = var.encrypt_execute_command_session ? 1 : 0
  source = "github.com/geekcell/terraform-aws-kms?ref=v1"

  alias = "ecs/cluster/${var.name}/ssm-logs"
  tags  = var.tags
}

# TODO: use geekcell/terraform-aws-cloudwatch-log-group module if it supports disabling KMS
resource "aws_cloudwatch_log_group" "main" {
  count = var.enable_execute_command_logging ? 1 : 0

  name = "/ecs/cluster/${var.name}/ssm-logs"
  tags = var.tags
}

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
    for_each = var.encrypt_execute_command_session || var.enable_execute_command_logging ? [true] : []

    content {
      execute_command_configuration {
        kms_key_id = var.encrypt_execute_command_session ? module.kms[0].key_id : null
        logging    = var.encrypt_execute_command_session ? "OVERRIDE" : "DEFAULT"

        dynamic "log_configuration" {
          for_each = var.enable_execute_command_logging ? [true] : []

          content {
            cloud_watch_encryption_enabled = true
            cloud_watch_log_group_name     = aws_cloudwatch_log_group.main[0].name
          }
        }
      }
    }
  }

  tags = var.tags
}

#TODO: Add capacity providers support
