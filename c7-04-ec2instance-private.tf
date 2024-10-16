module "ec2_private" {
  depends_on = [module.vpc, module.rdsdb,module.ec2_public_bastion]
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.7.0"
  name = "${var.environment}-private-instance"
  ami  = data.aws_ami.amzlinux2.id
  #ami = "ami-00f07845aed8c0ee7"
  instance_type = var.instance_type
  key_name = var.instance_keypair
  vpc_security_group_ids = [module.private_sg.security_group_id]
  for_each = toset(["0", "1"])
  subnet_id =  element(module.vpc.private_subnets, tonumber(each.key))
  user_data = templatefile("app1-install.tmpl", {
    DB_HOST     = module.rdsdb.db_instance_address,
    DB_USERNAME = module.rdsdb.db_instance_username,
    DB_PASSWORD = module.rdsdb.db_instance_password,
    DB_NAME     = module.rdsdb.db_instance_name
  })
  tags = local.common_tags
}






