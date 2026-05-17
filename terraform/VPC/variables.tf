# Variables pour le fichiers VPC/main.tf

variable "aws_region" {
  type        = string
  description = "Région AWS"
}

variable "vpc_cidr" {
  type        = string
  description = "Bloc CIDR du VPC"
}

variable "cidr_subnet_dev" {
  type        = string
  description = "Bloc CIDR de sous-réseau dev"
}

variable "cidr_subnet_prod" {
  type        = string
  description = "Bloc CIDR de sous-réseau prod"
}
