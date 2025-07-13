provider "aws" {
  region = var.region
}

resource "aws_db_subnet_group" "mongo_subnet_group" {
  name       = "mongo-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "mongo-subnet-group"
  }
}

resource "aws_docdb_subnet_group" "docdb_subnet_group" {
  name       = "docdb-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "docdb-subnet-group"
  }
}

resource "aws_docdb_cluster" "mongo_cluster" {
  cluster_identifier      = "observability-docdb"
  engine                  = "docdb"
  master_username         = "admin"
  master_password         = "SuperSecret123"
  db_subnet_group_name    = aws_docdb_subnet_group.docdb_subnet_group.name
  skip_final_snapshot     = true
  vpc_security_group_ids  = [var.security_group_id]
}

resource "aws_docdb_cluster_instance" "mongo_instance" {
  count              = 1
  identifier         = "docdb-instance-${count.index}"
  cluster_identifier = aws_docdb_cluster.mongo_cluster.id
  instance_class     = "db.t3.medium"
}
