
# resource "aws_ecr_repository" "order_service_repo" {
#   name = var.order_service_name
#   image_scanning_configuration { scan_on_push = true }
#   image_tag_mutability = "MUTABLE"
#   force_delete         = true
# }

# resource "aws_ecr_repository" "api_gateway_repo" {
#   name = var.api_gateway_name
#   image_scanning_configuration { scan_on_push = true }
#   image_tag_mutability = "MUTABLE"
#   force_delete         = true
# }
