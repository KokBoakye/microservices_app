output "ecs_cluster_id" {
  value       = aws_ecs_cluster.ecs_cluster.id
  description = "The ID of the ECS cluster."
}

output "log_group_name" {
  value       = aws_cloudwatch_log_group.log_group.name
  description = "The name of the CloudWatch log group for ECS."
}

output "namespace_id" {
  value       = aws_service_discovery_private_dns_namespace.microservices.id
  description = "The ID of the Service Discovery namespace."

}

output "iam_role_arn" {
  value       = aws_iam_role.ecs_task_execution_role.arn
  description = "The ARN of the ECS task execution IAM role."

}
