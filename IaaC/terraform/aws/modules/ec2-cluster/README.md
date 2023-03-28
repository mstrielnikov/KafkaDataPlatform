# EC2-cluster module

Internal module which provides interface to create multiple instances within given VPC with specified subnets.

```css
ec2-cluster/
    ├── main.tf
    ├── outputs.tf
    ├── providers.tf
    ├── variables.tf
    └── versions.tf
```

Example of module usage:
```terraform
module "ec2_cluster_kafka" {
  source  = "./modules/ec2-cluster"

  name                   = "kafka"
  name_suffix            = "-"
  instance_count         = 3
  instance_type          = "a1.xlarge"
  ami                    = data.aws_ami.ubuntu.id

  availability_zone      = var.availability_zone
  vpc_id                 = aws_vpc.kafka_cloud_vpc.id
  vpc_subnet_ids         = data.aws_subnet_ids.confluent_cloud_subnet_ids
  vpc_security_group_ids = [ aws_security_group.kafka_cloud_sg.id ]
  create_eip             = true
  monitoring             = true
  
  ssh_key_pair_name      = aws_key_pair.key_pair_ansible.key_name

  user_data = templatefile("./user_data.tpl", {
        ebs_disk_mount_path = "/dev/sdb"
        ebs_disk_path       = "/mnt/data"
    })

  tags = merge(
    {
      app    = "kafka",
      region = var.aws_region
    }, var.default_tags)
}


data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
```