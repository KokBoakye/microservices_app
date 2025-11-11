aws_region = "eu-north-1"

# VPC
vpc_cidr_block        = "10.0.0.0/16"
public_subnets_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets_cidrs = ["10.0.101.0/24", "10.0.102.0/24"]
availability_zones    = ["eu-north-1a", "eu-north-1b"]

name          = ["user-service", "order-service", "api-gateway"]
vpc_name      = "microservices-vpc"
cpu           = "256"
memory        = "512"
ecr_image     = "123456789012.dkr.ecr.eu-north-1.amazonaws.com/my-microservice:latest"
desired_count = 2
port          = 8080
project_name  = "microservices-app"





