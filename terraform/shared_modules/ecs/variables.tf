
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


variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where the ECS services will be deployed"
  type        = string
}
