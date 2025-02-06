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
    for_each = (
      var.encrypt_execute_command_session ||
      var.logging_execute_command_session != "DEFAULT" ||
      var.encrypt_ephemeral_storage ||
      var.encrypt_managed_storage
    ) ? [true] : []

    content {
      dynamic "execute_command_configuration" {
        for_each = var.encrypt_execute_command_session || var.logging_execute_command_session != "DEFAULT" ? [true] : []

        content {
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

      dynamic "managed_storage_configuration" {
        for_each = var.encrypt_ephemeral_storage || var.encrypt_managed_storage ? [true] : []

        content {
          kms_key_id                           = var.encrypt_managed_storage ? module.kms[0].key_id : null
          fargate_ephemeral_storage_kms_key_id = var.encrypt_ephemeral_storage ? module.kms_ephemeral[0].key_id : null
        }
      }
    }
  }

  tags = var.tags
}

module "kms" {
  count = var.encrypt_execute_command_session ? 1 : 0

  source  = "geekcell/kms/aws"
  version = ">= 1.0.0, < 2.0.0"

  alias = "ecs/cluster/${var.name}/ssm-logs"
  tags  = var.tags
}

resource "aws_cloudwatch_log_group" "main" {
  count = var.logging_execute_command_session == "OVERRIDE" ? 1 : 0

  name = "/ecs/cluster/${var.name}/ssm-logs"
  tags = var.tags
}

resource "aws_cloudwatch_log_group" "container_insights" {
  count = var.enable_container_insights ? 1 : 0

  name              = "/aws/ecs/containerinsights/${var.name}/performance"
  retention_in_days = 1

  tags = var.tags
}

module "kms_ephemeral" {
  count = var.encrypt_ephemeral_storage || var.encrypt_managed_storage ? 1 : 0

  source  = "geekcell/kms/aws"
  version = ">= 1.0.0, < 2.0.0"
  policy  = data.aws_iam_policy_document.kms_ephemeral[0].json

  alias = "ecs/cluster/${var.name}/managed-storage"
  tags  = var.tags
}

data "aws_caller_identity" "current" {}
data "aws_iam_policy_document" "kms_ephemeral" {
  count = var.encrypt_ephemeral_storage || var.encrypt_managed_storage ? 1 : 0

  statement {
    sid       = "Enable IAM User Permissions."
    effect    = "Allow"
    actions   = ["kms:*"]
    resources = ["*"]

    principals {
      identifiers = ["*"]
      type        = "AWS"
    }
  }

  statement {
    sid     = "Allow generate data key access for Fargate tasks."
    effect  = "Allow"
    actions = ["kms:GenerateDataKeyWithoutPlaintext"]

    principals {
      identifiers = ["fargate.amazonaws.com"]
      type        = "Service"
    }

    condition {
      test     = "StringEquals"
      variable = "kms:EncryptionContext:aws:ecs:clusterAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }

    condition {
      test     = "StringEquals"
      variable = "kms:EncryptionContext:aws:ecs:clusterName"
      values   = [var.name]
    }

    resources = ["*"]
  }

  statement {
    sid     = "Allow grant creation permission for Fargate tasks."
    effect  = "Allow"
    actions = ["kms:CreateGrant"]

    principals {
      identifiers = ["fargate.amazonaws.com"]
      type        = "Service"
    }

    condition {
      test     = "StringEquals"
      variable = "kms:EncryptionContext:aws:ecs:clusterAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }

    condition {
      test     = "StringEquals"
      variable = "kms:EncryptionContext:aws:ecs:clusterName"
      values   = [var.name]
    }

    condition {
      test     = "ForAllValues:StringEquals"
      variable = "kms:GrantOperations"
      values   = ["Decrypt"]
    }

    resources = ["*"]
  }
}
