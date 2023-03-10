<!-- BEGIN_TF_DOCS -->
[![Geek Cell GmbH](https://raw.githubusercontent.com/geekcell/template-terraform-module/main/docs/assets/logo.svg)](https://www.geekcell.io/)

### Code Quality
[![License](https://img.shields.io/github/license/geekcell/terraform-aws-ecs-cluster)](https://github.com/geekcell/terraform-aws-ecs-cluster/blob/master/LICENSE)
[![GitHub release (latest tag)](https://img.shields.io/github/v/release/geekcell/terraform-aws-ecs-cluster?logo=github&sort=semver)](https://github.com/geekcell/terraform-aws-ecs-cluster/releases)
[![Release](https://github.com/geekcell/terraform-aws-ecs-cluster/actions/workflows/release.yaml/badge.svg)](https://github.com/geekcell/terraform-aws-ecs-cluster/actions/workflows/release.yaml)
[![Validate](https://github.com/geekcell/terraform-aws-ecs-cluster/actions/workflows/validate.yaml/badge.svg)](https://github.com/geekcell/terraform-aws-ecs-cluster/actions/workflows/validate.yaml)
[![Lint](https://github.com/geekcell/terraform-aws-ecs-cluster/actions/workflows/linter.yaml/badge.svg)](https://github.com/geekcell/terraform-aws-ecs-cluster/actions/workflows/linter.yaml)

### Security
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/geekcell/terraform-aws-ecs-cluster/general)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=geekcell%2Fterraform-aws-ecs-cluster&benchmark=INFRASTRUCTURE+SECURITY)

#### Cloud
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/geekcell/terraform-aws-ecs-cluster/cis_aws)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=geekcell%2Fterraform-aws-ecs-cluster&benchmark=CIS+AWS+V1.2)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/geekcell/terraform-aws-ecs-cluster/cis_aws_13)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=geekcell%2Fterraform-aws-ecs-cluster&benchmark=CIS+AWS+V1.3)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/geekcell/terraform-aws-ecs-cluster/cis_azure)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=geekcell%2Fterraform-aws-ecs-cluster&benchmark=CIS+AZURE+V1.1)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/geekcell/terraform-aws-ecs-cluster/cis_azure_13)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=geekcell%2Fterraform-aws-ecs-cluster&benchmark=CIS+AZURE+V1.3)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/geekcell/terraform-aws-ecs-cluster/cis_gcp)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=geekcell%2Fterraform-aws-ecs-cluster&benchmark=CIS+GCP+V1.1)

##### Container
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/geekcell/terraform-aws-ecs-cluster/cis_kubernetes_16)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=geekcell%2Fterraform-aws-ecs-cluster&benchmark=CIS+KUBERNETES+V1.6)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/geekcell/terraform-aws-ecs-cluster/cis_eks_11)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=geekcell%2Fterraform-aws-ecs-cluster&benchmark=CIS+EKS+V1.1)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/geekcell/terraform-aws-ecs-cluster/cis_gke_11)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=geekcell%2Fterraform-aws-ecs-cluster&benchmark=CIS+GKE+V1.1)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/geekcell/terraform-aws-ecs-cluster/cis_kubernetes)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=geekcell%2Fterraform-aws-ecs-cluster&benchmark=CIS+KUBERNETES+V1.5)

#### Data protection
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/geekcell/terraform-aws-ecs-cluster/soc2)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=geekcell%2Fterraform-aws-ecs-cluster&benchmark=SOC2)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/geekcell/terraform-aws-ecs-cluster/pci)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=geekcell%2Fterraform-aws-ecs-cluster&benchmark=PCI-DSS+V3.2)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/geekcell/terraform-aws-ecs-cluster/pci_dss_v321)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=geekcell%2Fterraform-aws-ecs-cluster&benchmark=PCI-DSS+V3.2.1)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/geekcell/terraform-aws-ecs-cluster/iso)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=geekcell%2Fterraform-aws-ecs-cluster&benchmark=ISO27001)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/geekcell/terraform-aws-ecs-cluster/nist)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=geekcell%2Fterraform-aws-ecs-cluster&benchmark=NIST-800-53)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/geekcell/terraform-aws-ecs-cluster/hipaa)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=geekcell%2Fterraform-aws-ecs-cluster&benchmark=HIPAA)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/geekcell/terraform-aws-ecs-cluster/fedramp_moderate)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=geekcell%2Fterraform-aws-ecs-cluster&benchmark=FEDRAMP+%28MODERATE%29)

# Terraform AWS ECS Cluster

This Terraform module provides a preconfigured solution for setting up an Amazon Elastic Container Service (ECS)
Cluster with enabled Container Insights, logging, and advanced monitoring. With this module, you can easily launch,
manage, and scale your Docker containers and applications in the cloud while having complete visibility into their
performance and health.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_container_insights"></a> [enable\_container\_insights](#input\_enable\_container\_insights) | Enable CloudWatch Container Insights for the cluster. | `bool` | `true` | no |
| <a name="input_encrypt_execute_command_session"></a> [encrypt\_execute\_command\_session](#input\_encrypt\_execute\_command\_session) | Encrypt execute command session for the cluster. | `bool` | `true` | no |
| <a name="input_logging_execute_command_session"></a> [logging\_execute\_command\_session](#input\_logging\_execute\_command\_session) | DEFAULT | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the ECS cluster. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to add to the ECS cluster. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the ECS cluster. |
| <a name="output_command_session_cloudwatch_log_group_arn"></a> [command\_session\_cloudwatch\_log\_group\_arn](#output\_command\_session\_cloudwatch\_log\_group\_arn) | The ARN of the CloudWatch log group used to store the command session. |
| <a name="output_command_session_kms_arn"></a> [command\_session\_kms\_arn](#output\_command\_session\_kms\_arn) | The ARN of the KMS key used to encrypt the command session. |
| <a name="output_name"></a> [name](#output\_name) | The name of the ECS cluster. |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.36 |

## Resources

- resource.aws_cloudwatch_log_group.main (main.tf#54)
- resource.aws_ecs_cluster.main (main.tf#10)

# Examples
### Minimum
```hcl
module "min" {
  source = "../../"

  name = "my-cluster"
}
```
<!-- END_TF_DOCS -->
