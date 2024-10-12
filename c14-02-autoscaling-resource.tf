# Autoscaling Group Resource

resource "aws_autoscaling_group" "my_asg" {
  name = "${var.environment}-autoscaling-group"
  max_size = 3
  min_size = 2
  desired_capacity = 2
  vpc_zone_identifier = module.vpc.private_subnets  
  target_group_arns = [module.alb.target_groups["mytg1"].arn]
  health_check_type = "EC2"

  launch_template {
    id = aws_launch_template.my_launch_template.id
    version = "$Latest"
  }
  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 90
    }
    triggers = ["desired_capacity"]
  }
  tag {
    key = "Name"
    value = "${var.environment}-autoscaling-group"
    propagate_at_launch = true
  }
}


