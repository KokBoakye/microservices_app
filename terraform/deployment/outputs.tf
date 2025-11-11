output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "user_service_repository_url" {
  value       = module.ecr.user_service_repository_url
  description = "The url of the repository."
}
output "order_service_repository_url" {
  value       = module.ecr.order_service_repository_url
  description = "The url of the order service repository."
}
output "api_gateway_repository_url" {
  value       = module.ecr.api_gateway_repository_url
  description = "The url of the API gateway repository."
}
