## ec2_bastion_public_instance_ids
output "ec2_bastion_public_instance_ids" {
  value = module.ec2_public_bastion.id
}

## ec2_bastion_public_ip
output "ec2_bastion_public_ip" {
  value = module.ec2_public_bastion.public_ip
}

# Private EC2 Instances
## ec2_private_instance_ids
output "ec2_private_instance_ids" {
  value = [for ec2_private  in module.ec2_private : ec2_private.id]
}

## ec2_private_instance_ips
output "ec2_private_instance_ips" {
  value = [for ec2_private  in module.ec2_private : ec2_private.private_ip]
}

# EC2 with ignore AMI changes
output "ec2_ignore_ami_changes_ami" {
  description = "The AMI of the instance (ignore_ami_changes = true)"
  value       = [for ec2_private  in module.ec2_private : ec2_private.ami]
}

# EC2 with ignore AMI changes
output "ec2_public_bastion_ami" {
  description = "The AMI of the instance (ignore_ami_changes = true)"
  value       = module.ec2_public_bastion.ami
}
