# IAM Role for EC2 instances
resource "aws_iam_role" "role_ec2_instance" {
  name = "role-ec2-instance-${var.name}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Instance profile for EC2 instances
resource "aws_iam_instance_profile" "instance_profile" {
  name = "instance-profile-${var.name}"
  role = aws_iam_role.role_ec2_instance_.id
}

resource "aws_network_interface" "interface" {
  count           = var.instance_count
  subnet_id       = var.subnet_id
  private_ips     = [ "${cidrhost(var.interface_subnet_cidr, count.index+1)}" ]
  security_groups = [ var.vpc_security_group_ids ]
}

# EC2 instance configuration
resource "aws_instance" "instance" {
  count                  = var.instance_count
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  iam_instance_profile   = aws_iam_instance_profile.instance_profile.id

  network_interface {
    network_interface_id = aws_network_interface.interface[count.index].id
    device_index         = 0
  }

  credit_specification {
    cpu_credits = "unlimited"
  }

  root_block_device {
    volume_type           = var.root_block_device_map.volume_type
    volume_size           = var.root_block_device_map.volume_size
    delete_on_termination = var.root_block_device_map.delete_on_termination
  }
  
  ebs_block_device {
    device_name = var.ebs_block_device_map.device_name
    volume_type = var.ebs_block_device_map.volume_type
    volume_size = var.ebs_block_device_map.volume_size
    encrypted   = var.ebs_block_device_map.encrypted
  }

  
  key_name = var.ssh_key_pair_name

  # User data script to bootstrap instances
  user_data                   = var.user_data
  user_data_replace_on_change = true

  tags = {
    Name = "${var.name}${var.name_suffix}${count.index}"
  }
}
