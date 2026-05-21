

module "vpc" {
  source = "./VPC"

  # ajout des variables VPC
  aws_region       = var.aws_region
  vpc_cidr         = var.vpc_cidr
  cidr_subnet_public_1  = var.cidr_loadbalancer_a
  cidr_subnet_public_2  = var.cidr_loadbalancer_b
  cidr_subnet_private_1 = var.cidr_subnet_apps_a
  cidr_subnet_private_2 = var.cidr_subnet_apps_a
  ssh_allowed_cidr      = var.ssh_allowed_cidr
}

#module "EKS" {
# source = "./EKS"
#
  # ajout des variables EKS


