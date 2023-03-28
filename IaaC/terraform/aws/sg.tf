resource "aws_security_group" "kafka_cloud_sg" {
  name = "kafka_cloud_security_group"
  description = "Manage Kafka cloud infra security"
  vpc_id = aws_vpc.kafka_cloud.id
  
  tags = merge({
    "sg_name" = "kafka_cloud_security_group",
    "vpc_id"  = "${aws_vpc.kafka_cloud_vpc.id}",
  }, var.default_cloud_tags)

    # Necessary if changing 'name' or 'name_prefix' properties.
    lifecycle {
        create_before_destroy = true
  }

}

resource "aws_security_group_rule" "kafka_cloud_rule_ingress_all" {
  security_group_id = aws_security_group.kafka_cloud_sg.id
  
  type = "ingress"
  from_port   = 0
  to_port     = 65535
  protocol    = "tcp"
  cidr_blocks = [ "0.0.0.0/0" ]
}

resource "aws_security_group_rule" "kafka_cloud_rule_egress_all" {
  security_group_id = aws_security_group.kafka_cloud_sg.id
  
  type = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = [ "0.0.0.0/0" ]
}

resource "aws_security_group_rule" "kafka_cloud_rule_ingress_ssh" {
  security_group_id = aws_security_group.kafka_cloud_sg.id
  
  type = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = [ "0.0.0.0/0" ]
}

resource "aws_security_group_rule" "kafka_cloud_rule_ingress_https" {
  security_group_id = aws_security_group.kafka_cloud_sg.id
  
  type = "ingress"
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = [ "0.0.0.0/0" ]
}
