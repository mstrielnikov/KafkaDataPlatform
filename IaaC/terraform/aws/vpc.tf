resource "aws_vpc" "confluent_cloud_vpc" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = merge({
    vpc_name   = "confluent_cloud_vpc"
    cidr_block = "10.0.0.0/16"
  }, var.default_tags)

}

# Single-zone configuration
resource "aws_subnet" "confluent_cloud_subnet" {
  cidr_block        = "10.0.1.0/24"
  vpc_id            = aws_vpc.confluent_cloud_vpc.id
  /* availability_zone =  */
}


# Multi-zone configuration
/* resource "aws_subnet" "confluent_cloud_subnet" {
  count = 3
  cidr_block = "10.0.${count.index+1}.0/24"
  vpc_id            = aws_vpc.confluent_cloud_vpc.id
  availability_zone = var.availability_zone
} */

/* data "aws_subnet_ids" "confluent_cloud_subnet_ids" {
  vpc_id            = aws_vpc.confluent_cloud_vpc.id
  availability_zone = var.availability_zone
} */