<!-- BEGIN_TF_DOCS -->
[![Geek Cell GmbH](https://raw.githubusercontent.com/geekcell/.github/main/geekcell-github-banner.png)](https://www.geekcell.io/)

### Code Quality
[![License](https://img.shields.io/github/license/geekcell/terraform-aws-ecs-cluster)](https://github.com/geekcell/terraform-aws-ecs-cluster/blob/master/LICENSE)
[![GitHub release (latest tag)](https://img.shields.io/github/v/release/geekcell/terraform-aws-ecs-cluster?logo=github&sort=semver)](https://github.com/geekcell/terraform-aws-ecs-cluster/releases)
[![Release](https://github.com/geekcell/terraform-aws-ecs-cluster/actions/workflows/release.yaml/badge.svg)](https://github.com/geekcell/terraform-aws-ecs-cluster/actions/workflows/release.yaml)
[![Validate](https://github.com/geekcell/terraform-aws-ecs-cluster/actions/workflows/validate.yaml/badge.svg)](https://github.com/geekcell/terraform-aws-ecs-cluster/actions/workflows/validate.yaml)
[![Lint](https://github.com/geekcell/terraform-aws-ecs-cluster/actions/workflows/linter.yaml/badge.svg)](https://github.com/geekcell/terraform-aws-ecs-cluster/actions/workflows/linter.yaml)

# Terraform AWS ECS Cluster

This Terraform module provides a preconfigured solution for setting up an Amazon Elastic Container Service (ECS)
Cluster with enabled Container Insights, logging, and advanced monitoring. With this module, you can easily launch,
manage, and scale your Docker containers and applications in the cloud while having complete visibility into their
performance and health.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_container_insights"></a> [enable\_container\_insights](#input\_enable\_container\_insights) | Enable CloudWatch Container Insights for the cluster. | `bool` | `true` | no |
| <a name="input_encrypt_ephemeral_storage"></a> [encrypt\_ephemeral\_storage](#input\_encrypt\_ephemeral\_storage) | Encrypt the ECS ephemeral storage for the cluster. | `bool` | `false` | no |
| <a name="input_encrypt_execute_command_session"></a> [encrypt\_execute\_command\_session](#input\_encrypt\_execute\_command\_session) | Encrypt execute command session for the cluster. | `bool` | `false` | no |
| <a name="input_encrypt_managed_storage"></a> [encrypt\_managed\_storage](#input\_encrypt\_managed\_storage) | Encrypt the ECS managed storage for the cluster. | `bool` | `false` | no |
| <a name="input_logging_execute_command_session"></a> [logging\_execute\_command\_session](#input\_logging\_execute\_command\_session) | Log execute command session for the cluster. | `string` | `"DEFAULT"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the ECS cluster. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to add to the ECS cluster. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the ECS cluster. |
| <a name="output_command_session_cloudwatch_log_group_arn"></a> [command\_session\_cloudwatch\_log\_group\_arn](#output\_command\_session\_cloudwatch\_log\_group\_arn) | The ARN of the CloudWatch log group used to store the command session. |
| <a name="output_command_session_kms_arn"></a> [command\_session\_kms\_arn](#output\_command\_session\_kms\_arn) | The ARN of the KMS key used to encrypt the command session. |
| <a name="output_name"></a> [name](#output\_name) | The name of the ECS cluster. |
| <a name="output_storage_kms_arn"></a> [storage\_kms\_arn](#output\_storage\_kms\_arn) | The ARN of the KMS key used to encrypt the storage (managed and ephemeral). |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.59 |

## Resources

- resource.aws_cloudwatch_log_group.container_insights (main.tf#80)
- resource.aws_cloudwatch_log_group.main (main.tf#73)
- resource.aws_ecs_cluster.main (main.tf#10)
- data source.aws_caller_identity.current (main.tf#100)
- data source.aws_iam_policy_document.kms_storage (main.tf#101)

# Examples
### Basic Example
```hcl
module "basic-example" {
  source = "../../"

  name = var.name
}
```
<!-- END_TF_DOCS -->
