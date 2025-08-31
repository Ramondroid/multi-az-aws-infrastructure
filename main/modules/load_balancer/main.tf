resource "aws_lb" "alb" {
    name               = "${var.project_code["ProjectCode"]}-frontend-alb"
    internal           = var.frontend_internal
    load_balancer_type = var.load_balancer_type
    security_groups    = [aws_security_group.alb_sg.id]
    subnets            = var.public_subnet_ids
    
    enable_deletion_protection = false
    
    tags = { Name = "${var.project_code["ProjectCode"]}-fe-alb" }
}

resource "aws_lb_target_group" "fe_target_group" {
    name        = "${var.project_code["ProjectCode"]}-frontend-tg"
    port        = var.frontend_alb_tg_config.port
    protocol    = var.frontend_alb_tg_config.protocol
    vpc_id      = var.vpc_id
    target_type = var.frontend_alb_tg_config.target_type

    health_check {
        path                = var.frontend_alb_health_check_config.path
        protocol            = var.frontend_alb_health_check_config.protocol
        matcher             = var.frontend_alb_health_check_config.matcher
        interval            = var.frontend_alb_health_check_config.interval
        timeout             = var.frontend_alb_health_check_config.timeout
        healthy_threshold   = var.frontend_alb_health_check_config.healthy_threshold
        unhealthy_threshold = var.frontend_alb_health_check_config.unhealthy_threshold
    }
    
    tags = { Name = "${var.project_code["ProjectCode"]}-fe-al-tg" }
}

resource "aws_lb_listener" "fe_alb_listener" {
    load_balancer_arn = aws_lb.fe_alb.arn
    port              = var.frontend_alb_tg_config.port
    protocol          = var.frontend_alb_tg_config.protocol

    default_action {
        type             = var.frontend_alb_tg_config.action
        target_group_arn = aws_lb_target_group.fe_target_group.arn
    }
    
    tags = { Name = "${var.project_code["ProjectCode"]}-fe-alb-listener" }
}

resource "aws_lb" "be_alb" {
    name               = "${var.project_code["ProjectCode"]}-backend-alb"
    internal           = var.backend_internal
    load_balancer_type = var.load_balancer_type
    security_groups    = [aws_security_group.alb_sg.id]
    subnets            = var.public_subnet_ids
    
    enable_deletion_protection = false
    
    tags = { Name = "${var.project_code["ProjectCode"]}-be-alb" }
}

resource "aws_lb_target_group" "be_target_group" {
    name        = "${var.project_code["ProjectCode"]}-backend-tg"
    port        = var.backend_alb_tg_config.port
    protocol    = var.backend_alb_tg_config.protocol
    vpc_id      = var.vpc_id
    target_type = var.backend_alb_tg_config.target_type

    health_check {
        path                = var.backend_alb_health_check_config.path
        protocol            = var.backend_alb_health_check_config.protocol
        matcher             = var.backend_alb_health_check_config.matcher
        interval            = var.backend_alb_health_check_config.interval
        timeout             = var.backend_alb_health_check_config.timeout
        healthy_threshold   = var.backend_alb_health_check_config.healthy_threshold
        unhealthy_threshold = var.backend_alb_health_check_config.unhealthy_threshold
    }
    
    tags = { Name = "${var.project_code["ProjectCode"]}-be-al-tg" }
}

resource "aws_lb_listener" "be_alb_listener" {
    load_balancer_arn = aws_lb.be_alb.arn
    port              = var.backend_alb_tg_config.port
    protocol          = var.backend_alb_tg_config.protocol

    default_action {
        type             = var.backend_alb_tg_config.action
        target_group_arn = aws_lb_target_group.be_target_group.arn
    }
    
    tags = { Name = "${var.project_code["ProjectCode"]}-be-alb-listener" }
}