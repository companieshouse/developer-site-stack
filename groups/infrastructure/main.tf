provider "aws" {
  region = var.aws_region
}

terraform {
  required_version = ">= 1.3, < 2.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0, < 7.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = ">= 5.0, < 6.0"
    }
  }

  backend "s3" {}
}

moved {
  from = module.ecs-cluster
  to   = module.ecs_cluster
}

module "ecs_cluster" {
  source = "git@github.com:companieshouse/terraform-modules//aws/ecs/ecs-cluster?ref=1.0.437"

  stack_name  = local.stack_name
  name_prefix = local.name_prefix
  environment = var.environment
  vpc_id      = data.aws_vpc.vpc.id
  subnet_ids  = local.application_subnet_ids

  ec2_key_pair_name = var.ec2_key_pair_name
  ec2_instance_type = var.ec2_instance_type

  asg_max_instance_count       = var.asg_max_instance_count
  asg_min_instance_count       = var.asg_min_instance_count
  enable_container_insights    = var.enable_container_insights
  asg_desired_instance_count   = var.asg_desired_instance_count
  scaledown_schedule           = var.asg_scaledown_schedule
  scaleup_schedule             = var.asg_scaleup_schedule
  notify_topic_slack_endpoints = sensitive([local.notify_topic_slack_endpoint])

  default_tags = merge(
    module.iac_tags.tags,
    module.owner_tags.tags,
  )
}

moved {
  from = module.albs.aws_lb.dev-site-alb
  to   = module.dev_alb.aws_lb.alb
}

moved {
  from = module.albs.aws_lb_listener.dev-site-alb-listener
  to   = module.dev_alb.aws_lb_listener.listeners["listener_config"]
}

module "dev_alb" {
  source = "git@github.com:companieshouse/terraform-modules//aws/application_load_balancer?ref=tags/1.0.437"

  environment                 = var.environment
  service                     = "dev-site-${var.environment}-lb"
  load_balancer_name_override = "dev-site-${var.environment}-lb"
  ssl_certificate_arn         = data.aws_acm_certificate.cert.arn
  subnet_ids                  = local.lb_subnet_ids
  vpc_id                      = data.aws_vpc.vpc.id
  idle_timeout                = 60
  create_security_group       = true
  internal                    = var.internal_albs
  ingress_cidrs               = local.lb_access_cidrs
  ingress_prefix_list_ids     = local.web_access_prefix_list_ids
  redirect_http_to_https      = true
  route53_domain_name         = length(var.route53_aliases_dev) > 0 ? data.aws_route53_zone.zone[0].name : ""
  route53_aliases             = var.route53_aliases_dev
  service_configuration = {
    listener_config = {
      default_action_type = "fixed-response"
      port                = 443
    }
  }
}

moved {
  from = module.albs.aws_lb.dev-specs-alb
  to   = module.dev_specs_alb.aws_lb.alb
}

moved {
  from = module.albs.aws_lb_listener.dev-specs-alb-listener
  to   = module.dev_specs_alb.aws_lb_listener.listeners["listener_config"]
}

module "dev_specs_alb" {
  source = "git@github.com:companieshouse/terraform-modules//aws/application_load_balancer?ref=tags/1.0.437"

  environment                 = var.environment
  service                     = "dev-specs-${var.environment}-lb"
  load_balancer_name_override = "dev-specs-${var.environment}-lb"
  ssl_certificate_arn         = data.aws_acm_certificate.cert.arn
  subnet_ids                  = local.lb_subnet_ids
  vpc_id                      = data.aws_vpc.vpc.id
  idle_timeout                = 60
  create_security_group       = true
  internal                    = var.internal_albs
  ingress_cidrs               = local.lb_access_cidrs
  ingress_prefix_list_ids     = local.web_access_prefix_list_ids
  redirect_http_to_https      = true
  route53_domain_name         = length(var.route53_aliases_dev_specs) > 0 ? data.aws_route53_zone.zone[0].name : ""
  route53_aliases             = var.route53_aliases_dev_specs
  service_configuration = {
    listener_config = {
      default_action_type = "fixed-response"
      port                = 443
    }
  }
}

module "iac_tags" {
  source = "git@github.com:companieshouse/terraform-modules//aws/tagging/iac?ref=tags/1.0.437"

  group           = "infrastructure"
  source_code_url = "https://github.com/companieshouse/developer-site-stack"
}

module "owner_tags" {
  source = "git@github.com:companieshouse/terraform-modules//aws/tagging/owner?ref=tags/1.0.437"

  platform_owner = "platform"
}
