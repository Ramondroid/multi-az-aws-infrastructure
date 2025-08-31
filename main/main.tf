module "vpc" {
  source                  = "./modules/network"
  project_code            = var.project_code
  vpc_config              = var.vpc_config
  public_subnets          = var.public_subnets
  private_subnets         = var.private_subnets
  map_public_ip_on_launch = var.map_public_ip_on_launch
  domain_type             = var.domain_type
}

module "security_groups" {
  source         = "./modules/security_groups"
  project_code   = var.project_code
  vpc_id         = module.vpc.vpc_id
  security_group = var.security_group
  ingress_rules = [
    {
      description       = "Allow SSH to Bastion"
      from_port         = 22
      protocol          = "tcp"
      to_port           = 22
      cidr_block        = ""
      security_group_id = module.security_groups.security_group["bastion-sg"].id
    },
    {
      description       = "Allow HTTP to Frontend ALB"
      from_port         = var.HTTP_port
      protocol          = var.TCP_protocol
      to_port           = var.HTTP_port
      cidr_block        = var.Any_cidr
      security_group_id = module.security_groups.security_group["frontend-alb-sg"].id
    },
    {
      description       = "Allow SSH to Frontend ASG"
      from_port         = var.SSH_port
      protocol          = var.TCP_protocol
      to_port           = var.SSH_port
      source_sg_id      = module.security_groups.security_group["bastion-sg"].id
      security_group_id = module.security_groups.security_group["frontend-asg-sg"].id
    },
    {
      description       = "Allow HTTP to Frontend ASG"
      from_port         = var.HTTP_port
      protocol          = var.TCP_protocol
      to_port           = var.HTTP_port
      source_sg_id      = module.security_groups.security_group["frontend-alb-sg"].id
      security_group_id = module.security_groups.security_group["frontend-asg-sg"].id
    },
    {
      description       = "Allow HTTP to Backend ALB"
      from_port         = var.HTTP_port
      protocol          = var.TCP_protocol
      to_port           = var.HTTP_port
      source_sg_id      = module.security_groups.security_group["frontend-asg-sg"].id
      security_group_id = module.security_groups.security_group["backend-asg-sg"].id
    },
    {
      description       = "Allow SSH to Backend ASG"
      from_port         = var.SSH_port
      protocol          = var.TCP_protocol
      to_port           = var.SSH_port
      source_sg_id      = module.security_groups.security_group["bastion-sg"].id
      security_group_id = module.security_groups.security_group["backend-asg-sg"].id
    },
    {
      description       = "Allow HTTP to Backend ASG"
      from_port         = var.HTTP_port
      protocol          = var.TCP_protocol
      to_port           = var.HTTP_port
      source_sg_id      = module.security_groups.security_group["backend-alb-sg"].id
      security_group_id = module.security_groups.security_group["backend-asg-sg"].id
    }

  ]
  egress_rules = [
    {
      description       = "From Bastion to Any"
      from_port         = var.Any_port
      protocol          = var.Any_protocol
      to_port           = var.Any_port
      cidr_block        = var.Any_cidr
      security_group_id = module.security_groups.security_group["bastion-sg"].id
    },
    {
      description       = "From Frontend ALB To Frontend ASG"
      from_port         = var.HTTP_port
      protocol          = var.TCP_protocol
      to_port           = var.HTTP_port
      source_sg_id      = module.security_groups.security_group["frontend-asg-sg"].id
      security_group_id = module.security_groups.security_group["frontend-alb-sg"].id
    },
    {
      description       = "From Frontend ASG To Any"
      from_port         = var.Any_port
      protocol          = var.Any_protocol
      to_port           = var.Any_port
      cidr_block        = var.Any_cidr
      security_group_id = module.security_groups.security_group["frontend-asg-sg"].id
    },
    {
      description       = "From Backend ALB to Backend ASG"
      from_port         = var.HTTP_port
      protocol          = var.TCP_protocol
      to_port           = var.HTTP_port
      source_sg_id      = module.security_groups.security_group["backend-asg-sg"].id
      security_group_id = module.security_groups.security_group["backend-alb-sg"].id
    },
    {
      description       = "From Backend ASG To Any"
      from_port         = var.Any_port
      protocol          = var.Any_protocol
      to_port           = var.Any_port
      cidr_block        = var.Any_cidr
      security_group_id = module.security_groups.security_group["backend-asg-sg"].id
    }
  ]
}

module "bastion_host" {
  source                = "./modules/bastion_host"
  project_code          = var.project_code
  bastion_config        = var.bastion_config
  subnet_id             = element(module.vpc.public_subnet_ids, 0)
  security_group_ids    = [module.security_groups.security_group["bastion-sg"].id]
  bastion_public_enable = var.bastion_public_enable
  data_most_recent      = var.data_most_recent
}

module "frontend_alb" {
  source               = "./modules/load_balancer"
  project_code         = var.project_code
  load_balancer_config = var.frontend_load_balancer_config
  health_check_config  = var.health_check_config
  subnet_ids           = module.network.public_subnet_ids
  load_balancer_type   = var.load_balancer_type
  vpc_id               = module.network.vpc_id
}

module "backend_alb" {
  source               = "./modules/load_balancer"
  project_code         = var.project_code
  load_balancer_config = var.backend_load_balancer_config
  health_check_config  = var.health_check_config
  subnet_ids           = module.network.private_subnet_ids
  load_balancer_type   = var.load_balancer_type
  vpc_id               = module.network.vpc_id
}

module "frontend_asg" {
  source                 = "./modules/auto_scaling_group"
  project_code           = var.project_code
  asg_config             = var.frontend_asg_config
  launch_template_config = var.frontend_launch_template_config
  subnet_ids             = [module.network.private_subnet_frontend_asg_ids]
  security_group_ids     = [module.security_groups.security_group["frontend-asg-sg"].id]
  data_most_recent       = var.data_most_recent
  scale_in_config        = var.scale_in_config
  scale_out_config       = var.scale_out_config
  cpu_high_alarm_config  = var.cpu_high_alarm_config
  cpu_low_alarm_config   = var.cpu_low_alarm_config
  user_data              = base64encode(replace(file("${path.module}/userdata/frontend_userdata.sh"), "@@BACKEND_URL@@", module.backend_alb.alb_dns))
}

module "backend_asg" {
  source                 = "./modules/auto_scaling_group"
  project_code           = var.project_code
  asg_config             = var.backend_asg_config
  launch_template_config = var.backend_launch_template_config
  subnet_ids             = [module.network.private_subnet_backend_asg_ids]
  security_group_ids     = [module.security_groups.security_group["backend-asg-sg"].id]
  data_most_recent       = var.data_most_recent
  scale_in_config        = var.scale_in_config
  scale_out_config       = var.scale_out_config
  cpu_high_alarm_config  = var.cpu_high_alarm_config
  cpu_low_alarm_config   = var.cpu_low_alarm_config
  user_data              = file("userdata/backend_userdata.sh")
}