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
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.66.0 |
| <a name="provider_vault"></a> [vault](#provider\_vault) | 5.12.0 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_dev_alb"></a> [dev\_alb](#module\_dev\_alb) | git@github.com:companieshouse/terraform-modules//aws/application_load_balancer | tags/1.0.437 |
| <a name="module_dev_specs_alb"></a> [dev\_specs\_alb](#module\_dev\_specs\_alb) | git@github.com:companieshouse/terraform-modules//aws/application_load_balancer | tags/1.0.437 |
| <a name="module_ecs_cluster"></a> [ecs\_cluster](#module\_ecs\_cluster) | git@github.com:companieshouse/terraform-modules//aws/ecs/ecs-cluster | 1.0.431 |
| <a name="module_iac_tags"></a> [iac\_tags](#module\_iac\_tags) | git@github.com:companieshouse/terraform-modules//aws/tagging/iac | tags/1.0.431 |
| <a name="module_owner_tags"></a> [owner\_tags](#module\_owner\_tags) | git@github.com:companieshouse/terraform-modules//aws/tagging/owner | tags/1.0.431 |

## Resources

| Name | Type |
| ---- | ---- |
| [aws_acm_certificate.cert](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/acm_certificate) | data source |
| [aws_ec2_managed_prefix_list.admin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ec2_managed_prefix_list) | data source |
| [aws_ec2_managed_prefix_list.concourse](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ec2_managed_prefix_list) | data source |
| [aws_kms_key.stack_configs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_key) | data source |
| [aws_route53_zone.zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |
| [aws_subnet.application](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnets.application](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_subnets.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |
| [vault_generic_secret.secrets](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/generic_secret) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_asg_desired_instance_count"></a> [asg\_desired\_instance\_count](#input\_asg\_desired\_instance\_count) | The desired number of instances in the autoscaling group for the cluster. Must fall within the min/max instance count range. | `number` | `0` | no |
| <a name="input_asg_max_instance_count"></a> [asg\_max\_instance\_count](#input\_asg\_max\_instance\_count) | The maximum allowed number of instances in the autoscaling group for the cluster. | `number` | `0` | no |
| <a name="input_asg_min_instance_count"></a> [asg\_min\_instance\_count](#input\_asg\_min\_instance\_count) | The minimum allowed number of instances in the autoscaling group for the cluster. | `number` | `0` | no |
| <a name="input_asg_scaledown_schedule"></a> [asg\_scaledown\_schedule](#input\_asg\_scaledown\_schedule) | The schedule to use when scaling down the number of EC2 instances to zero. | `string` | `""` | no |
| <a name="input_asg_scaleup_schedule"></a> [asg\_scaleup\_schedule](#input\_asg\_scaleup\_schedule) | The schedule to use when scaling up the number of EC2 instances to their normal desired level. | `string` | `""` | no |
| <a name="input_aws_profile"></a> [aws\_profile](#input\_aws\_profile) | The AWS profile to use for deployment. | `string` | `"development-eu-west-2"` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region for deployment. | `string` | `"eu-west-2"` | no |
| <a name="input_cert_domain"></a> [cert\_domain](#input\_cert\_domain) | The domain name for the SSL certificate to be used for the ALB. | `string` | n/a | yes |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The domain name for the Route 53 zone | `string` | `""` | no |
| <a name="input_ec2_instance_type"></a> [ec2\_instance\_type](#input\_ec2\_instance\_type) | The instance type for ec2 instances in the clusters. | `string` | `"t3.medium"` | no |
| <a name="input_ec2_key_pair_name"></a> [ec2\_key\_pair\_name](#input\_ec2\_key\_pair\_name) | The key pair for SSH access to ec2 instances in the clusters. | `string` | n/a | yes |
| <a name="input_enable_asg_autoscaling"></a> [enable\_asg\_autoscaling](#input\_enable\_asg\_autoscaling) | Whether to enable auto-scaling of the ASG by creating a capacity provider for the ECS cluster. | `bool` | `true` | no |
| <a name="input_enable_concourse_access"></a> [enable\_concourse\_access](#input\_enable\_concourse\_access) | Defines whether access will be permitted from Concourse (true) or not (false) | `bool` | `false` | no |
| <a name="input_enable_container_insights"></a> [enable\_container\_insights](#input\_enable\_container\_insights) | A boolean value indicating whether to enable Container Insights or not | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name, defined in envrionments vars. | `string` | n/a | yes |
| <a name="input_hashicorp_vault_password"></a> [hashicorp\_vault\_password](#input\_hashicorp\_vault\_password) | The password used when retrieving configuration from Hashicorp Vault | `string` | n/a | yes |
| <a name="input_hashicorp_vault_username"></a> [hashicorp\_vault\_username](#input\_hashicorp\_vault\_username) | The username used when retrieving configuration from Hashicorp Vault | `string` | n/a | yes |
| <a name="input_internal_albs"></a> [internal\_albs](#input\_internal\_albs) | Whether the ALBs should be internal or public facing | `bool` | `true` | no |
| <a name="input_route53_aliases_dev"></a> [route53\_aliases\_dev](#input\_route53\_aliases\_dev) | The list of Route 53 aliases for the dev ALB. | `list(string)` | `[]` | no |
| <a name="input_route53_aliases_dev_specs"></a> [route53\_aliases\_dev\_specs](#input\_route53\_aliases\_dev\_specs) | The list of Route 53 aliases for the dev specs ALB. | `list(string)` | `[]` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
