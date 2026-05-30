# Subnet group RDS (subnets privés)
resource "aws_db_subnet_group" "main" {
  name       = "infoline-rds-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name        = "infoline-rds-subnet-group"
    Environment = "Production"
  }
}

# Security group RDS — accès uniquement depuis le VPC
resource "aws_security_group" "rds_sg" {
  name        = "infoline-rds-sg"
  description = "PostgreSQL depuis le VPC"
  vpc_id      = var.vpc_id

  ingress {
    description = "PostgreSQL depuis le VPC"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "infoline-rds-sg"
    Environment = "Production"
  }
}

# Instance RDS PostgreSQL
resource "aws_db_instance" "main" {
  identifier        = "infoline-postgres"
  engine            = "postgres"
  engine_version    = "15.12"
  instance_class    = var.db_instance_class
  allocated_storage = 20
  storage_type      = "gp3"
  storage_encrypted = true

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  # Haute disponibilité
  multi_az = false   # passer à true en production

  # Sauvegardes
  backup_retention_period = 0 #FreeTierRestriction pas de Sauvegardes automatique
#  backup_window           = "00:00-00:00" # FreeTierRestriction
  maintenance_window      = "sun:04:00-sun:05:00"

  # Pas d'accès public
  publicly_accessible = false

  # Suppression protégée en prod
  deletion_protection = false   # passer à true en production
  skip_final_snapshot = true    # passer à false en production

  tags = {
    Name        = "infoline-postgres"
    Environment = "Production"
  }
}
