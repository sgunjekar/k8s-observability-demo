output "vpc_id" {
  value = aws_vpc.observability_vpc.id
}

output "subnet_ids" {
  value = [
    aws_subnet.public1.id,
    aws_subnet.public2.id
  ]
}