resource "aws_security_group" "security_group" {
  for_each = var.security_group
  name     = "${var.project_code["ProjectCode"]}-${each.value.name}"
  vpc_id   = var.vpc_id
  tags = {
    Name = "${var.project_code["ProjectCode"]}-${each.value.name}"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ingress" {
  for_each = {
    for idx, rule in var.ingress_rules : idx => rule
  }

  security_group_id            = each.value.security_group_id
  from_port                    = each.value.from_port
  to_port                      = each.value.to_port
  ip_protocol                  = each.value.ip_protocol
  cidr_ipv4                    = lookup(each.value, "cidr_block", null)
  referenced_security_group_id = loockup(each.value, "source_sg_id", null)
  description                  = each.value.description
}

resource "aws_vpc_security_group_egress_rule" "egress" {
  for_each = {
    for idx, rule in var.egress_rules : idx => rule
  }

  security_group_id            = each.value.security_group_id
  from_port                    = each.value.from_port
  to_port                      = each.value.to_port
  ip_protocol                  = each.value.ip_protocol
  cidr_ipv4                    = lookup(each.value, "cidr_block", null)
  referenced_security_group_id = loockup(each.value, "source_sg_id", null)
  description                  = each.value.description
}