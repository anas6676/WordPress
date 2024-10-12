# Security Group for RDS DB
module "rdsdb_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.2.0"
  name = "rdsdb_sg"
  description = "Security Group for RDS DB"
  vpc_id = module.vpc.vpc_id


# Open to CIDRs blocks (rule or from_port+to_port+protocol+description)
  ingress_with_cidr_blocks = [
    {           
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "RDS DB from VPC"
      cidr_blocks = module.vpc.vpc_cidr_block
    },
  ]

#Egress rules
  egress_rules = ["all-all"]
  egress_cidr_blocks = ["0.0.0.0/0"]
  tags= local.common_tags

}