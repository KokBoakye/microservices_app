aws_region                   = "eu-north-1"
order_service_name           = "order-service"
vpc_name                     = "microservices-vpc"
cpu                          = "256"
memory                       = "512"
order_service_ecr_image      = "604312263409.dkr.ecr.eu-north-1.amazonaws.com/order-service:latest"
desired_count                = 2
order_service_container_port = 8002
project_name                 = "microservices-app"





