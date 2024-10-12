resource "aws_eip" "bastion_eip" {
  depends_on = [module.ec2_public_bastion,module.vpc]
  tags = local.common_tags
  instance = module.ec2_public_bastion.id
  domain   = "vpc"
}