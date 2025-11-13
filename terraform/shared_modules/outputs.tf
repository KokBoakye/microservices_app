output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "target_group_arn" {
  value = module.alb.target_group_arn

}

output "vpc_id" {
  value = module.vpc.vpc_id

}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "private_subnets" {
  value = module.vpc.private_subnets
}
output "ecs_cluster_id" {
  value = module.ecs.ecs_cluster_id
}

output "ecs_log_group_name" {
  value = module.ecs.log_group_name
}

output "ecs_namespace_id" {
  value = module.ecs.namespace_id
}

output "ecs_iam_role_arn" {
  value = module.ecs.iam_role_arn
}

output "order_service_sg_id" { value = module.alb.order_service_sg_id }

output "user_service_sg_id" { value = module.alb.user_service_sg_id }

output "api_gateway_sg_id" { value = module.alb.api_gateway_sg_id }
