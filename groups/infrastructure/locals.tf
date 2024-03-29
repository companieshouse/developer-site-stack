locals {
  stack_name     = "developer-site"
  stack_fullname = "${local.stack_name}-stack"
  name_prefix    = "${local.stack_name}-${var.environment}"

  stack_secrets = jsondecode(data.vault_generic_secret.secrets.data_json)

  application_subnet_pattern  = local.stack_secrets["application_subnet_pattern"]
  public_subnet_pattern       = local.stack_secrets["public_subnet_pattern"]
  application_subnet_ids      = join(",", data.aws_subnets.application.ids)
  kms_key_alias               = local.stack_secrets["kms_key_alias"]
  vpc_name                    = local.stack_secrets["vpc_name"]
  notify_topic_slack_endpoint = local.stack_secrets["notify_topic_slack_endpoint"]

  parameter_store_secrets = {
    "vpc-name"                 = local.stack_secrets["vpc_name"],
    "web-oauth2-client-id"     = local.stack_secrets["web-oauth2-client-id"],
    "web-oauth2-client-secret" = local.stack_secrets["web-oauth2-client-secret"],
    "web-oauth2-cookie-secret" = local.stack_secrets["web-oauth2-cookie-secret"],
    "web-oauth2-request-key"   = local.stack_secrets["web-oauth2-request-key"]
  }

  application_ids   = data.aws_subnets.application.ids
  application_cidrs = [for s in data.aws_subnet.application : s.cidr_block]
  public_ids        = data.aws_subnets.public.ids
  public_cidrs      = [for s in data.aws_subnet.public : s.cidr_block]

  public_lb_cidrs    = ["0.0.0.0/0"]
  iboss_access_cidrs = ["10.40.250.0/24"]

  lb_subnet_ids   = var.internal_albs ? local.application_ids : local.public_ids # place ALB in correct subnets 
  lb_access_cidrs = (var.internal_albs ? concat(local.internal_cidrs, local.vpn_cidrs, local.management_private_subnet_cidrs, local.iboss_access_cidrs, local.application_cidrs) : local.public_lb_cidrs)

  internal_cidrs                  = values(data.terraform_remote_state.networks_common_infra.outputs.internal_cidrs)
  vpn_cidrs                       = values(data.terraform_remote_state.networks_common_infra.outputs.vpn_cidrs)
  management_private_subnet_cidrs = values(data.terraform_remote_state.networks_common_infra_ireland.outputs.management_private_subnet_cidrs)

}
