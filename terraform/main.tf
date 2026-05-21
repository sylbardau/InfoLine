

module "vpc" {
  source = "./VPC"

  # ajout des variables VPC
  aws_region       = var.aws_region
  vpc_cidr         = var.vpc_cidr
  cidr_subnet_loadbalancer_a  = var.cidr_subnet_loadbalancer_a
  cidr_subnet_loadbalancer_b  = var.cidr_subnet_loadbalancer_b
  cidr_subnet_apps_a = var.cidr_subnet_apps_a
  cidr_subnet_apps_b = var.cidr_subnet_apps_b
  ssh_allowed_cidr      = var.ssh_allowed_cidr
}

#module "EKS" {
# source = "./EKS"
#
  # ajout des variables EKS


