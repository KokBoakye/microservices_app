aws_region                  = "eu-north-1"
user_service_name           = "user-service"
vpc_name                    = "microservices-vpc"
cpu                         = "256"
memory                      = "512"
user_service_ecr_image      = "604312263409.dkr.ecr.eu-north-1.amazonaws.com/user-service:latest"
desired_count               = 2
user_service_container_port = 8001
project_name                = "microservices-app"





