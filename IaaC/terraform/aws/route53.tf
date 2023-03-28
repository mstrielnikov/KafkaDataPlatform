resource "aws_route53_zone" "confluent_cloud_private" {
  name = "confluent-cloud.loc"
  
  vpc {
    vpc_id     = aws_vpc.confluent_cloud_vpc.id
    /* vpc_region =  */
  }

}

resource "aws_route53_record" "kafka_record" {
  /* count   */
  zone_id = aws_route53_zone.confluent_cloud_private.zone_id
  records = aws_route53_zone.confluent_cloud_private.name_servers
  name    = "kafka.confluent-cloud.loc"
  type    = "NS"
  ttl     = "30"
}

resource "aws_route53_record" "schema_registry_record" {
  /* count   */
  zone_id = aws_route53_zone.confluent_cloud_private.zone_id
  records = aws_route53_zone.confluent_cloud_private.name_servers
  name    = "schema-registry.confluent-cloud.loc"
  type    = "NS"
  ttl     = "30"
}

resource "aws_route53_record" "kafka_control_center_record" {
  zone_id = aws_route53_zone.confluent_cloud_private.zone_id
  records = aws_route53_zone.confluent_cloud_private.name_servers
  name    = "control-center.confluent-cloud.loc"
  type    = "NS"
  ttl     = "30"
}

resource "aws_route53_record" "ksqldb_record" {
  /* count   */
  zone_id = aws_route53_zone.confluent_cloud_private.zone_id
  records = aws_route53_zone.confluent_cloud_private.name_servers
  name    = "ksqldb.confluent-cloud.loc"
  type    = "NS"
  ttl     = "30"
}

resource "aws_route53_record" "connect_record" {
  /* count   */
  zone_id = aws_route53_zone.confluent_cloud_private.zone_id
  records = aws_route53_zone.confluent_cloud_private.name_servers
  name    = "connect.confluent-cloud.loc"
  type    = "NS"
  ttl     = "30"
}