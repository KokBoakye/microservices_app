aws_region = "eu-north-1"

# VPC
vpc_cidr_block        = "10.0.0.0/16"
public_subnets_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets_cidrs = ["10.0.101.0/24", "10.0.102.0/24"]
availability_zones    = ["eu-north-1a", "eu-north-1b"]

name           = ["api-gateway", "user-service", "order-service"]
vpc_name       = "microservices-vpc"
cpu            = "256"
memory         = "512"
ecr_image      = ["604312263409.dkr.ecr.eu-north-1.amazonaws.com/user-service:latest", "604312263409.dkr.ecr.eu-north-1.amazonaws.com/order-service:latest", "604312263409.dkr.ecr.eu-north-1.amazonaws.com/api-gateway:latest"]
desired_count  = 2
container_port = [8000, 8001, 8002]
project_name   = "microservices-app"





