variable "aws_region" {
  description = "AWS region"
  type        = string

}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}



variable "user_service_name" {
  description = "The name of the user service"
  type        = string

}


variable "cpu" {
  type    = string
  default = "256"
}
variable "memory" {
  type    = string
  default = "512"
}


variable "user_service_ecr_image" {
  description = "The ECR image URI for the ECS service"
  type        = string

}

variable "desired_count" {
  type = number

}

variable "user_service_container_port" {
  description = "The container port to expose"
  type        = number

}

variable "project_name" {
  description = "The project name"
  type        = string
}
