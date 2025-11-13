data "terraform_remote_state" "shared_modules" {
  backend = "s3"
  config = {
    bucket = "microservices-terraform-state-10-nov"
    key    = "shared/terraform.tfstate"
    region = "eu-north-1"
  }
}


resource "aws_ecr_repository" "user_service_repo" {
  name = var.user_service_name
  image_scanning_configuration { scan_on_push = true }
  image_tag_mutability = "MUTABLE"
  force_delete         = true
}


resource "aws_ecs_task_definition" "user_service_task_definition" {
  family                   = var.user_service_name
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  network_mode             = "awsvpc"
  execution_role_arn       = data.terraform_remote_state.shared_modules.outputs.ecs_iam_role_arn
  task_role_arn            = data.terraform_remote_state.shared_modules.outputs.ecs_iam_role_arn

  container_definitions = jsonencode([
    {
      name         = var.user_service_name
      image        = var.user_service_ecr_image
      essential    = true
      portMappings = [{ containerPort = var.user_service_container_port }]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/${var.project_name}"
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = var.project_name
        }
      }
      # environment = var.environment
    }
  ])
}

resource "aws_ecs_service" "user_service_ecs_service" {
  name            = var.user_service_name
  cluster         = data.terraform_remote_state.shared_modules.outputs.ecs_cluster_id
  desired_count   = var.desired_count
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.user_service_task_definition.arn

  network_configuration {
    subnets          = data.terraform_remote_state.shared_modules.outputs.private_subnets
    security_groups  = [data.terraform_remote_state.shared_modules.outputs.user_service_sg_id]
    assign_public_ip = true
  }

  service_registries {
    registry_arn = aws_service_discovery_service.user_service.arn
  }

  load_balancer {
    target_group_arn = data.terraform_remote_state.shared_modules.outputs.target_group_arn
    container_name   = var.user_service_name
    container_port   = var.user_service_container_port
  }
}


resource "aws_service_discovery_service" "user_service" {
  name = "user-service"
  dns_config {
    namespace_id = data.terraform_remote_state.shared_modules.outputs.ecs_namespace_id
    dns_records {
      type = "A"
      ttl  = 10
    }
    routing_policy = "MULTIVALUE"
  }

}






