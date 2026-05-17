

module "vpc" {
  source = "./VPC"

  # ajout des variables VPC
  aws_region       = var.aws_region
  vpc_cidr         = var.vpc_cidr
  cidr_subnet_dev  = var.cidr_subnet_dev
  cidr_subnet_prod = var.cidr_subnet_prod
}
