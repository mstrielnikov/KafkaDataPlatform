# Output the Kafka broker IPs
output "kafka_brokers" {
  value = aws_instance.kafka_instance.*.private_ip
}
