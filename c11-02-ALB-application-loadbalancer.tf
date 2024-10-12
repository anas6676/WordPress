# Terraform AWS Application Load Balancer (ALB)

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "9.4.0"

  name    = "${local.name}-alb"
  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.public_subnets

  security_groups = [module.loadbalancer_sg.security_group_id]

  tags = local.common_tags

  enable_deletion_protection = false

# Listeners
listeners = {
    my-https-listener = {
      port            = 80
      protocol        = "HTTP"
      forward = {
        target_group_key = "mytg1"
      }
    }
  }
# Target Groups 

  target_groups = {
    mytg1 = {
      create_attachment = false
      name_prefix                       = "mytg1-"
      protocol                          = "HTTP"
      port                              = 80
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = false
      protocol_version = "HTTP1"

      target_group_health = {
        dns_failover = {
          minimum_healthy_targets_count = 2
        }
        unhealthy_state_routing = {
          minimum_healthy_targets_percentage = 50
        }
      }

      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }

    }


}
}

resource "aws_lb_target_group_attachment" "mytg1" {
  for_each = {for k,v in module.ec2_private: k => v }
  target_group_arn = module.alb.target_groups["mytg1"].arn
  target_id        = each.value.id
  port             = 80
}


/*output "zz_ec2_private" {
  #value = {for k, v in module.ec2_private: k => v}
  value = {for ec2_instance, ec2_instance_details in module.ec2_private: ec2_instance => ec2_instance_details}
}
*/