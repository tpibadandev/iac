# Create an output for the public_dns of each EC2 instance and db endpoint
output "db_endpoint" {
  value = aws_db_instance.default.endpoint
}
output "ec2" {
  value = {
    for name, this in aws_instance.ec2 : name => this.public_dns
  }
}