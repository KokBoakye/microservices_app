output "alb_arn" { value = aws_lb.loadbalancer.arn }
output "target_group_arn" { value = aws_lb_target_group.target_group.arn }

output "alb_dns_name" {
  value = aws_lb.loadbalancer.dns_name
}
output "order_service_sg_id" { value = aws_security_group.order_service_sg.id }

output "user_service_sg_id" { value = aws_security_group.user_service_sg.id }

output "api_gateway_sg_id" { value = aws_security_group.api_gateway_sg.id }
