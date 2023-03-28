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
  subnet_id       = var.subnet_id
  private_ips     = [ "10.0.0.50" ]
  security_groups = [ var.vpc_security_group_ids ]
}

# EC2 instance configuration
resource "aws_instance" "instance" {
  count                  = var.instance_count
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.vpc_subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  iam_instance_profile   = aws_iam_instance_profile.instance_profile.id

  network_interface {
    network_interface_id = aws_network_interface.interface.id
    device_index         = 0
  }

  credit_specification {
    cpu_credits = "unlimited"
  }

  /* root_block_device */
  /* ebs_block_device */
  
  key_name = var.ssh_key_pair_name

  # User data script to bootstrap instances
  user_data                   = var.user_data
  user_data_replace_on_change = true

  tags = {
    Name = "${var.name}${var.name_suffix}${count.index}"
  }
}
