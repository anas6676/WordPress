module "ec2_public_bastion" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.7.0"
  name = "${var.environment}-public-bastionHost"
  ami  = data.aws_ami.amzlinux2.id
  #ami ="ami-00f07845aed8c0ee7"
  instance_type = var.instance_type
  key_name = var.instance_keypair
  subnet_id = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.public_bastion_sg.security_group_id]
  tags = local.common_tags
  }
 
  


