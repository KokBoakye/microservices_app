aws_region = "eu-north-1"

api_gateway_name           = "api-gateway"
vpc_name                   = "microservices-vpc"
cpu                        = "256"
memory                     = "512"
api_gateway_ecr_image      = "604312263409.dkr.ecr.eu-north-1.amazonaws.com/api-gateway:latest"
desired_count              = 2
api_gateway_container_port = 8000
project_name               = "microservices-app"





