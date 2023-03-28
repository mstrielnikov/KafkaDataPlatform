# Output the Kafka broker IPs
output "instances_ips_list" {
  value = aws_instance.instance.*.private_ip
}

