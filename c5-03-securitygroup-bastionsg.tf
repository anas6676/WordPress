module "public_bastion_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.2.0"
  name = "public_bastion_sg"
  description = "Security Group with SSH port open for everybody (IPv4 CIDR), egress ports are all world open"
  vpc_id = module.vpc.vpc_id

#Ingrss rules
  ingress_rules = ["ssh-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]

#Egress rules
  egress_rules = ["all-all"]
  egress_cidr_blocks = ["0.0.0.0/0"]
  tags= local.common_tags

}