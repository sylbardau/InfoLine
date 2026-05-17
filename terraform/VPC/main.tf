#	 VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "vpc-main"
    Environment = "Multi-Env"
  }
}

# 	Passerelle Internet
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-igw"
  }
}

# 	Sous-réseau DEV
resource "aws_subnet" "dev" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.cidr_subnet_dev
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags = {
    Name        = "subnet-dev"
    Environment = "Development"
  }
}

#	Sous-réseau PROD
resource "aws_subnet" "prod" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.cidr_subnet_prod
  availability_zone       = "${var.aws_region}a" # Mise en place possible d'une haute disponibilité en remplacant la lettre a par b apres la variable 
  map_public_ip_on_launch = true

  tags = {
    Name        = "subnet-prod"
    Environment = "Production"
  }
}

# 	Table de routage publique
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "rt-public"
  }
}

# 	Associations des Tables de Routage
resource "aws_route_table_association" "dev" {
  subnet_id      = aws_subnet.dev.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "prod" {
  subnet_id      = aws_subnet.prod.id
  route_table_id = aws_route_table.public.id
}

# 	Groupes de Sécurité (Security Groups)

# SG Dev : SSH et http
resource "aws_security_group" "sg_dev" {
  name        = "sg_development"
  description = "group de securite Dev"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP pour les tests"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "sg-dev"
    Environment = "Development"
  }
}

# SG Prod : HTTP/HTTPS et SSH
resource "aws_security_group" "sg_prod" {
  name        = "sg_production"
  description = "group de securite pour la Prod"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  ingress {
    description = "HTTPS"
    from_port   = 44
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "sg-prod"
    Environment = "Production"
  }
}
