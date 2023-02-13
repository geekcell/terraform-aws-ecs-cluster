/**
 * # Terraform AWS ECS Cluster
 *
 * This Terraform module provides a preconfigured solution for setting up an Amazon Elastic Container Service (ECS)
 * Cluster with enabled Container Insights, logging, and advanced monitoring. With this module, you can easily launch,
 * manage, and scale your Docker containers and applications in the cloud while having complete visibility into their
 * performance and health.
 *
 * The module includes encryption for command sessions to ensure the privacy and protection of your data. It also
 * includes Container Insights, a feature that provides in-depth operational visibility into your containers and
 * applications running on the ECS Cluster. With Container Insights, you can monitor performance metrics, identify
 * issues, and resolve them quickly to optimize your ECS environment for better performance and efficiency.
 *
 * In addition, this Terraform module includes advanced logging and monitoring capabilities, making it easy to track
 * and troubleshoot any issues with your ECS cluster. The logging feature provides detailed information about the
 * activity within your ECS cluster, while the advanced monitoring allows you to set up custom alarms to proactively
 * identify and address potential problems.
 *
 * Our team has extensive experience working with AWS ECS and has optimized this Terraform module to provide a
 * seamless experience for users. Whether you are just getting started with containers or looking to enhance your
 * current setup, this module provides a preconfigured solution for efficiently managing your ECS Cluster with enabled
 * Container Insights, logging, and advanced monitoring.
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

module "kms" {
  count  = var.encrypt_execute_command_session ? 1 : 0
  source = "github.com/geekcell/terraform-aws-kms?ref=v1.0"

  alias = "ecs/cluster/${var.name}/ssm-logs"
  tags  = var.tags
}

# TODO: use geekcell/terraform-aws-cloudwatch-log-group module if it supports disabling KMS
resource "aws_cloudwatch_log_group" "main" {
  count = var.enable_execute_command_logging ? 1 : 0

  name = "/ecs/cluster/${var.name}/ssm-logs"
  tags = var.tags
}
