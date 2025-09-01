resource "aws_security_group" "security_group" {
  for_each = var.security_group
  name     = "${var.project_code["ProjectCode"]}-${each.value.name}"
  vpc_id   = var.vpc_id
  tags = {
    Name = "${var.project_code["ProjectCode"]}-${each.value.name}"
  }
}