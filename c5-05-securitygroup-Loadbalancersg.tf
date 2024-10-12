# Security Group for Public Load Balancer
module "loadbalancer_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.2.0"
  name = "loadbalancer_sg"
  description = "Security Group with HTTP open for everybody (IPv4 CIDR), egress ports are all world open"
  vpc_id = module.vpc.vpc_id

#Ingrss rules
  ingress_rules = ["http-80-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]

# Open to CIDRs blocks (rule or from_port+to_port+protocol+description)
  ingress_with_cidr_blocks = [
    {
      from_port   = 81
      to_port     = 81
      protocol    = 6
      description = "Service name"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

#Egress rules
  egress_rules = ["all-all"]
  egress_cidr_blocks = ["0.0.0.0/0"]
  tags= local.common_tags

}