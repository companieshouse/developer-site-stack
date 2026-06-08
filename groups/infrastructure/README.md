# infrastructure

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3, < 2.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.0, < 7.0 |
| <a name="requirement_vault"></a> [vault](#requirement\_vault) | >= 5.0, < 6.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.49.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |
| <a name="provider_vault"></a> [vault](#provider\_vault) | 5.9.0 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_albs"></a> [albs](#module\_albs) | ./module-albs | n/a |
| <a name="module_ecs-cluster"></a> [ecs-cluster](#module\_ecs-cluster) | git@github.com:companieshouse/terraform-modules//aws/ecs/ecs-cluster | 1.0.231 |
| <a name="module_secrets"></a> [secrets](#module\_secrets) | git@github.com:companieshouse/terraform-modules//aws/ecs/secrets | 1.0.228 |

## Resources

| Name | Type |
| ---- | ---- |
| [aws_ec2_managed_prefix_list.admin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ec2_managed_prefix_list) | data source |
| [aws_ec2_managed_prefix_list.concourse](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ec2_managed_prefix_list) | data source |
| [aws_kms_key.stack_configs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_key) | data source |
| [aws_subnet.application](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnets.application](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_subnets.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |
| [terraform_remote_state.networks_common_infra_ireland](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [vault_generic_secret.secrets](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/generic_secret) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_asg_desired_instance_count"></a> [asg\_desired\_instance\_count](#input\_asg\_desired\_instance\_count) | The desired number of instances in the autoscaling group for the cluster. Must fall within the min/max instance count range. | `number` | `0` | no |
| <a name="input_asg_max_instance_count"></a> [asg\_max\_instance\_count](#input\_asg\_max\_instance\_count) | The maximum allowed number of instances in the autoscaling group for the cluster. | `number` | `0` | no |
| <a name="input_asg_min_instance_count"></a> [asg\_min\_instance\_count](#input\_asg\_min\_instance\_count) | The minimum allowed number of instances in the autoscaling group for the cluster. | `number` | `0` | no |
| <a name="input_asg_scaledown_schedule"></a> [asg\_scaledown\_schedule](#input\_asg\_scaledown\_schedule) | The schedule to use when scaling down the number of EC2 instances to zero. | `string` | `""` | no |
| <a name="input_asg_scaleup_schedule"></a> [asg\_scaleup\_schedule](#input\_asg\_scaleup\_schedule) | The schedule to use when scaling up the number of EC2 instances to their normal desired level. | `string` | `""` | no |
| <a name="input_aws_bucket"></a> [aws\_bucket](#input\_aws\_bucket) | The bucket used to store the current terraform state files | `string` | n/a | yes |
| <a name="input_aws_profile"></a> [aws\_profile](#input\_aws\_profile) | The AWS profile to use for deployment. | `string` | `"development-eu-west-2"` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region for deployment. | `string` | `"eu-west-2"` | no |
| <a name="input_deploy_to"></a> [deploy\_to](#input\_deploy\_to) | Bucket namespace used with remote\_state\_bucket and state\_prefix. | `string` | n/a | yes |
| <a name="input_ec2_image_id"></a> [ec2\_image\_id](#input\_ec2\_image\_id) | The machine image name for the ECS cluster launch configuration. | `string` | `"ami-04018f95156d810bc"` | no |
| <a name="input_ec2_instance_type"></a> [ec2\_instance\_type](#input\_ec2\_instance\_type) | The instance type for ec2 instances in the clusters. | `string` | `"t3.medium"` | no |
| <a name="input_ec2_key_pair_name"></a> [ec2\_key\_pair\_name](#input\_ec2\_key\_pair\_name) | The key pair for SSH access to ec2 instances in the clusters. | `string` | n/a | yes |
| <a name="input_enable_asg_autoscaling"></a> [enable\_asg\_autoscaling](#input\_enable\_asg\_autoscaling) | Whether to enable auto-scaling of the ASG by creating a capacity provider for the ECS cluster. | `bool` | `true` | no |
| <a name="input_enable_concourse_access"></a> [enable\_concourse\_access](#input\_enable\_concourse\_access) | Defines whether access will be permitted from COncourse (true) or not (false) | `bool` | `false` | no |
| <a name="input_enable_container_insights"></a> [enable\_container\_insights](#input\_enable\_container\_insights) | A boolean value indicating whether to enable Container Insights or not | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name, defined in envrionments vars. | `string` | n/a | yes |
| <a name="input_external_top_level_domain"></a> [external\_top\_level\_domain](#input\_external\_top\_level\_domain) | The type levelel of the DNS domain for external access. | `string` | n/a | yes |
| <a name="input_hashicorp_vault_password"></a> [hashicorp\_vault\_password](#input\_hashicorp\_vault\_password) | The password used when retrieving configuration from Hashicorp Vault | `string` | n/a | yes |
| <a name="input_hashicorp_vault_username"></a> [hashicorp\_vault\_username](#input\_hashicorp\_vault\_username) | The username used when retrieving configuration from Hashicorp Vault | `string` | n/a | yes |
| <a name="input_internal_albs"></a> [internal\_albs](#input\_internal\_albs) | Whether the ALBs should be internal or public facing | `bool` | `true` | no |
| <a name="input_remote_state_bucket"></a> [remote\_state\_bucket](#input\_remote\_state\_bucket) | Alternative bucket used to store the remote state files from ch-service-terraform | `string` | n/a | yes |
| <a name="input_ssl_certificate_id"></a> [ssl\_certificate\_id](#input\_ssl\_certificate\_id) | The ARN of the certificate for https access through the ALB. | `string` | n/a | yes |
| <a name="input_state_prefix"></a> [state\_prefix](#input\_state\_prefix) | The bucket prefix used with the remote\_state\_bucket files. | `string` | n/a | yes |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | The ID of the hosted zone to contain the Route 53 record. | `string` | `""` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
