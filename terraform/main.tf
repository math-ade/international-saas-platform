terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "saas_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = { Name = "international-saas-vpc" }
}

resource "aws_subnet" "public_alb" {
  vpc_id                  = aws_vpc.saas_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags                    = { Name = "saas-public-alb" }
}

resource "aws_subnet" "private_compute" {
  vpc_id            = aws_vpc.saas_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags              = { Name = "saas-private-compute" }
}

resource "aws_security_group" "cluster_sg" {
  name        = "saas-cluster-security-rules"
  vpc_id      = aws_vpc.saas_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/16"]
  }

  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "workers" {
  count         = 2
  ami           = "ami-01816d07b1128cd2d"
  instance_type = "t3.medium"
  subnet_id     = aws_subnet.private_compute.id
  vpc_security_group_ids = [aws_security_group.cluster_sg.id]

  tags = {
    Name = "saas-worker-${count.index + 1}"
    Tier = "production-compute"
  }
}
