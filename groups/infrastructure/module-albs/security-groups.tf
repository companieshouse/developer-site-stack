resource "aws_security_group" "dev-site-sg" {
  description = "Security group for dev site albs"
  vpc_id      = var.vpc_id

  tags = {
    Environment = var.environment
    Name        = "${var.name_prefix}-alb-sg"
  }
}

resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.dev-site-sg.id

  description = "Permit egress access to all"
  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}

resource "aws_vpc_security_group_ingress_rule" "http_cidrs" {
  for_each = toset(var.web_access_cidrs)

  security_group_id = aws_security_group.dev-site-sg.id

  description = "Permit HTTP access from ${each.value}"
  cidr_ipv4   = each.value
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}

resource "aws_vpc_security_group_ingress_rule" "http_prefix_lists" {
  for_each = var.internal_albs ? toset(var.web_access_prefix_list_ids) : []

  security_group_id = aws_security_group.dev-site-sg.id

  description    = "Permit HTTP access from ${each.value}"
  from_port      = 80
  ip_protocol    = "tcp"
  prefix_list_id = each.value
  to_port        = 80
}

resource "aws_vpc_security_group_ingress_rule" "https_cidrs" {
  for_each = toset(var.web_access_cidrs)

  security_group_id = aws_security_group.dev-site-sg.id

  description = "Permit HTTPS access from ${each.value}"
  cidr_ipv4   = each.value
  from_port   = 443
  ip_protocol = "tcp"
  to_port     = 443
}

resource "aws_vpc_security_group_ingress_rule" "https_prefix_lists" {
  for_each = var.internal_albs ? toset(var.web_access_prefix_list_ids) : []

  security_group_id = aws_security_group.dev-site-sg.id

  description    = "Permit HTTPS access from ${each.value}"
  from_port      = 443
  ip_protocol    = "tcp"
  prefix_list_id = each.value
  to_port        = 443
}
