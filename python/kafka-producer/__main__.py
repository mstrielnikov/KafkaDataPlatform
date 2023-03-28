from kafka import KafkaProducer

# Define the Kafka producer configuration
producer = KafkaProducer(
    bootstrap_servers=['localhost:9092'],
    value_serializer=lambda x: x.encode('utf-8')
)

# Send a message to a Kafka topic
producer.send('my_topic', value='Hello, Kafka!')

# Flush the producer to ensure all messages are sent
producer.flush()