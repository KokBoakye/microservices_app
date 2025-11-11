resource "aws_ecr_repository" "user_service_repo" {
  name = var.name[0]
  image_scanning_configuration { scan_on_push = true }
  image_tag_mutability = "MUTABLE"
  force_delete         = true
}

resource "aws_ecr_repository" "order_service_repo" {
  name = var.name[1]
  image_scanning_configuration { scan_on_push = true }
  image_tag_mutability = "MUTABLE"
  force_delete         = true
}

resource "aws_ecr_repository" "api_gateway_repo" {
  name = var.name[2]
  image_scanning_configuration { scan_on_push = true }
  image_tag_mutability = "MUTABLE"
  force_delete         = true
}
