# Environment
variable "environment" {
  type        = string
  description = "The environment name, defined in envrionments vars."
}

variable "aws_region" {
  default     = "eu-west-2"
  type        = string
  description = "The AWS region for deployment."
}

variable "aws_profile" {
  default     = "development-eu-west-2"
  type        = string
  description = "The AWS profile to use for deployment."
}

# EC2
variable "ec2_key_pair_name" {
  type        = string
  description = "The key pair for SSH access to ec2 instances in the clusters."
}

variable "ec2_instance_type" {
  default     = "t3.medium"
  type        = string
  description = "The instance type for ec2 instances in the clusters."
}

# Auto-scaling Group
variable "asg_max_instance_count" {
  default     = 0
  type        = number
  description = "The maximum allowed number of instances in the autoscaling group for the cluster."
}

variable "asg_min_instance_count" {
  default     = 0
  type        = number
  description = "The minimum allowed number of instances in the autoscaling group for the cluster."
}

variable "asg_desired_instance_count" {
  default     = 0
  type        = number
  description = "The desired number of instances in the autoscaling group for the cluster. Must fall within the min/max instance count range."
}

variable "asg_scaledown_schedule" {
  default     = ""
  type        = string
  description = "The schedule to use when scaling down the number of EC2 instances to zero."
}

variable "asg_scaleup_schedule" {
  default     = ""
  type        = string
  description = "The schedule to use when scaling up the number of EC2 instances to their normal desired level."
}

variable "enable_asg_autoscaling" {
  default     = true
  type        = bool
  description = "Whether to enable auto-scaling of the ASG by creating a capacity provider for the ECS cluster."
}

# DNS
variable "cert_domain" {
  type        = string
  description = "The domain name for the SSL certificate to be used for the ALB."
}

variable "domain_name" {
  type        = string
  description = "The domain name for the Route 53 zone"
  default     = ""
}

variable "route53_aliases_dev" {
  type        = list(string)
  description = "The list of Route 53 aliases for the dev ALB."
  default     = []
}

variable "route53_aliases_dev_specs" {
  type        = list(string)
  description = "The list of Route 53 aliases for the dev specs ALB."
  default     = []
}


# Networking
variable "enable_concourse_access" {
  type        = bool
  description = "Defines whether access will be permitted from Concourse (true) or not (false)"
  default     = false
}

variable "internal_albs" {
  type        = bool
  description = "Whether the ALBs should be internal or public facing"
  default     = true
}


# Container Insights - ECS
variable "enable_container_insights" {
  type        = bool
  description = "A boolean value indicating whether to enable Container Insights or not"
  default     = false
}
