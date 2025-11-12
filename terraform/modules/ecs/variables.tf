variable "name" { type = list(string) }
variable "ecr_image" { type = list(string) }
variable "cpu" {
  type    = string
  default = "256"
}
variable "memory" {
  type    = string
  default = "512"
}
variable "container_cpu" {
  type    = number
  default = 256
}
variable "container_memory" {
  type    = number
  default = 512
}
variable "container_port" { type = list(number) }
variable "subnet_ids" { type = list(string) }
variable "alb_target_group_arn" { type = string }
variable "desired_count" {
  type    = number
  default = 2
}
variable "aws_region" { type = string }
variable "environment" {
  type    = list(string)
  default = []
}

variable "user_service_sg" {
  type = string
}

variable "order_service_sg" {
  type = string
}

variable "api_gateway_sg" {
  type = string
}
variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where the ECS services will be deployed"
  type        = string
}
