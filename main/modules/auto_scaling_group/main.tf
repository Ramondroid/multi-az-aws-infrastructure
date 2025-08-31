data "aws_ami" "amazon_linux_2" {
    most_recent = var.data_most_recent
    filter {
        name   = "name"
        values = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }
    owners = ["amazon"] # Amazon
}

resource "aws_launch_template" "launch_template" {
    name_prefix   = "${var.project_code["ProjectCode"]}-lunch-template-"
    image_id      = var.data.aws_ami.amazon_linux_2.id
    instance_type = var.launch_template_config.instance_type
    key_name      = var.launch_template_config.key_name
    user_data = base64encode(var.launch_template_config.user_data)
    vpc_security_group_ids = var.security_group_ids
    tag_specifications {
        resource_type = "instance"
        tags = {
            Name = "${var.project_code["ProjectCode"]}-instance"
        }
    }
}

resource "aws_autoscaling_group" "asg" {
    name = "${var.project_code["ProjectCode"]}-asg"
    desired_capacity         = var.asg_config.desired_capacity
    max_size                 = var.asg_config.max_size
    min_size                 = var.asg_config.min_size
    health_check_type        = var.asg_config.health_check_type
    health_check_grace_period = var.asg_config.health_check_grace_period
    vpc_zone_identifier      = var.asg_config.vpc_zone_identifier
    launch_template {
        id      = aws_launch_template.launch_template.id
        version = "$Latest"
    }
    lifecycle {
      ignore_changes = [ 
        desired_capacity
       ]
    }
}

resource "aws_autoscaling_policy" "scale_out" {
    name = "${var.project_code["ProjectCode"]}-scale-out-policy"
    scaling_adjustment = var.scale_out.adjustment
    adjustment_type = var.scale_out.adjustment_type
    cooldown = var.scale_out.cooldown
    autoscaling_group_name = aws_autoscaling_group.asg.name
}

resource "aws_autoscaling_policy" "scale_in" {
    name = "${var.project_code["ProjectCode"]}-scale-in-policy"
    scaling_adjustment = var.scale_in.adjustment
    adjustment_type = var.scale_in.adjustment_type
    cooldown = var.scale_in.cooldown
    autoscaling_group_name = aws_autoscaling_group.asg.name
  
}

resource "aws_cloudwatch_metric_alarm" "cpu_high_alarm" {
    alarm_name          = "${var.project_code["ProjectCode"]}-cpu-high-alarm"
    comparison_operator = var.cpu_high_alarm_config.comparison_operator
    evaluation_periods  = var.cpu_high_alarm_config.evaluation_periods
    metric_name         = var.cpu_high_alarm_config.metric_name
    namespace           = var.cpu_high_alarm_config.namespace
    period              = var.cpu_high_alarm_config.period
    statistic           = var.cpu_high_alarm_config.statistic
    threshold           = var.cpu_high_alarm_config.threshold

    dimensions = {
        AutoScalingGroupName = aws_autoscaling_group.asg.name
    }

    alarm_actions = [aws_autoscaling_policy.scale_out.arn]
}

resource "aws_cloudwatch_metric_alarm" "cpu_low_alarm" {
    alarm_name          = "${var.project_code["ProjectCode"]}-cpu-low-alarm"
    comparison_operator = var.cpu_low_alarm_config.comparison_operator
    evaluation_periods  = var.cpu_low_alarm_config.evaluation_periods
    metric_name         = var.cpu_low_alarm_config.metric_name
    namespace           = var.cpu_low_alarm_config.namespace
    period              = var.cpu_low_alarm_config.period
    statistic           = var.cpu_low_alarm_config.statistic
    threshold           = var.cpu_low_alarm_config.threshold

    dimensions = {
        AutoScalingGroupName = aws_autoscaling_group.asg.name
    }

    alarm_actions = [aws_autoscaling_policy.scale_in.arn]
}

