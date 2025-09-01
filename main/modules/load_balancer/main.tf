resource "aws_lb" "alb" {
  name               = var.load_balancer_config.name
  internal           = var.load_balancer_config.internal
  load_balancer_type = var.load_balancer_type
  security_groups    = var.security_group_ids
  subnets            = var.subnet_ids

  tags = { Name = "${var.project_code["ProjectCode"]}-alb" }
}

resource "aws_lb_target_group" "target_group" {
  name        = "${var.load_balancer_config.name}-tg"
  port        = var.load_balancer_config.port
  protocol    = var.load_balancer_config.protocol
  vpc_id      = var.vpc_id
  target_type = var.load_balancer_config.target_type

  health_check {
    path                = var.health_check_config.path
    protocol            = var.health_check_config.protocol
    matcher             = var.health_check_config.matcher
    interval            = var.health_check_config.interval
    timeout             = var.health_check_config.timeout
    healthy_threshold   = var.health_check_config.healthy_threshold
    unhealthy_threshold = var.health_check_config.unhealthy_threshold
  }

  tags = { Name = "${var.project_code["ProjectCode"]}-alb-tg" }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.load_balancer_config.port
  protocol          = var.load_balancer_config.protocol

  default_action {
    type             = var.load_balancer_config.action
    target_group_arn = aws_lb_target_group.target_group.arn
  }

  tags = { Name = "${var.project_code["ProjectCode"]}-alb-listener" }
}