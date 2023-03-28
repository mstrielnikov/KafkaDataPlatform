# Create an internal network load balancer to communicate with other services and clusters within private network
resource "aws_lb" "kafka_nlb" {
  name               = "nlb-confluent-internal"
  internal           = true
  load_balancer_type = "network"

  subnet_mapping {
    subnet_id = aws_subnet.confluent_cloud_subnet.id
  }

  tags = {
    Name = "nlb-confluent-internal"
  }
}

# Register the Kafka brokers as targets for the NLB
resource "aws_lb_target_group" "kafka_brokers_tg" {
  for_each = var.kafka_port_mapping
  name_prefix = "kafka_brokers_tg"

  port     = each.value
  protocol = "TCP"
  vpc_id   = aws_vpc.confluent_cloud_vpc.id

  target_type = "instance"

  health_check {
    port     = each.value
    protocol = "TCP"
  }
}

resource "aws_lb_target_group_attachment" "kafka_brokers_tg_attachment" {
  for_each = module.instances_ids_list

  target_group_arn = aws_lb_target_group.kafka_brokers_tg.arn
  target_id        = each.value
}
