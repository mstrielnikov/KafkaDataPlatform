variable "default_tags" {
    type = map(string)
}

variable "kafka_port_mapping" {
    type = map(number)
    default = {
        listener = 9092
        exporter = 9090
    }
}