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

module "ec2_cluster_kafka" {
  source  = "./modules/ec2-cluster"

  name                   = "kafka"
  name_suffix            = "-"
  instance_count         = 3
  instance_type          = "a1.xlarge"
  ami                    = data.aws_ami.ubuntu.id

  vpc_id                 = aws_vpc.kafka_cloud_vpc.id
  vpc_security_group_ids = [ aws_security_group.kafka_cloud_sg.id ]
  subnet_id              = aws_subnet.confluent_cloud_subnet.id
  subnet_interface_cidr  = "10.0.1.0"
  create_eip             = true
  monitoring             = true
  
  ssh_key_pair_name      = aws_key_pair.key_pair_ansible.key_name

  user_data = templatefile("./user_data.tpl", {
        ebs_disk_mount_path = "/dev/sdb"
        ebs_disk_path       = "/mnt/data"
    })

  tags = merge({
      app    = "kafka",
    }, var.default_tags)
}