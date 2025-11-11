variable "aws_region" {
  description = "AWS region"
  type        = string

}

variable "vpc_cidr_block" {
  description = "The cidr of the VPC"
  type        = string
}
variable "public_subnets_cidrs" {
  description = "The list of public subnet cidrs"
  type        = list(string)
}
variable "private_subnets_cidrs" {
  description = "The list of private subnet cidrs"
  type        = list(string)
}
variable "availability_zones" {
  description = "The list of availability zones"
  type        = list(string)
}
variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "name" {
  description = "The name prefix for resources"
  type        = list(string)

}

variable "cpu" {
  type    = string
  default = "256"
}
variable "memory" {
  type    = string
  default = "512"
}


variable "ecr_image" {
  description = "The ECR image URI for the ECS service"
  type        = string

}

variable "desired_count" {
  type = number

}

variable "port" {
  description = "The container port to expose"
  type        = number

}

variable "project_name" {
  description = "The project name"
  type        = string
}
