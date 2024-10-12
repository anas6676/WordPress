resource "aws_launch_template" "my_launch_template" {
  name = "my_launch_template"  

  block_device_mappings {
    device_name = "/dev/sdf"

    ebs {
      volume_size = 20
      delete_on_termination = true
      volume_type = "gp2"
    }
  }

  ebs_optimized = true

  image_id = "ami-00f07845aed8c0ee7"
  instance_type = var.instance_type

  instance_initiated_shutdown_behavior = "terminate"

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }

  monitoring {
    enabled = true
  }
  vpc_security_group_ids = [ module.private_sg.security_group_id ]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "myACG"
    }
  }

  user_data = base64encode(templatefile("app1-install.tmpl", {
        DB_HOST     = module.rdsdb.db_instance_address,
        DB_USERNAME = module.rdsdb.db_instance_username,
        DB_PASSWORD = module.rdsdb.db_instance_password,
        DB_NAME     = module.rdsdb.db_instance_name
    }))

}
