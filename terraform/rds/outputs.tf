output "mongo_endpoint" {
  value = aws_docdb_cluster.mongo_cluster.endpoint
}

output "mongo_port" {
  value = aws_docdb_cluster.mongo_cluster.port
}
