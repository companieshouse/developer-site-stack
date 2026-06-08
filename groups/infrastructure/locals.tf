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

  lb_subnet_ids   = var.internal_albs ? local.application_ids : local.public_ids # place ALB in correct subnets 
  lb_access_cidrs = (var.internal_albs ? concat(local.management_private_subnet_cidrs, local.application_cidrs) : local.public_lb_cidrs)

  management_private_subnet_cidrs = values(data.terraform_remote_state.networks_common_infra_ireland.outputs.management_private_subnet_cidrs)

  admin_prefix_list_id     = data.aws_ec2_managed_prefix_list.admin.id
  concourse_prefix_list_id = var.enable_concourse_access ? data.aws_ec2_managed_prefix_list.concourse[0].id : ""

  web_access_prefix_list_ids = compact([
    local.admin_prefix_list_id,
    local.concourse_prefix_list_id
  ])
}
