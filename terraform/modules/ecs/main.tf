resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.project_name

}

resource "aws_ecs_task_definition" "user_service_task_definition" {
  family                   = var.name[0]
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name         = var.name[0]
      image        = var.ecr_image[0]
      essential    = true
      portMappings = [{ containerPort = var.container_port[0] }]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/${var.project_name}"
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = var.project_name
        }
      }
      environment = var.environment
    }
  ])
}

resource "aws_ecs_service" "user_service_ecs_service" {
  name            = var.name[0]
  cluster         = aws_ecs_cluster.ecs_cluster.id
  desired_count   = var.desired_count
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.user_service_task_definition.arn

  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = [var.user_service_sg]
    assign_public_ip = true
  }

  service_registries {
    registry_arn = aws_service_discovery_service.user_service.arn
  }

  load_balancer {
    target_group_arn = var.alb_target_group_arn
    container_name   = var.name[0]
    container_port   = var.container_port[0]
  }
}

resource "aws_cloudwatch_log_group" "this" {
  name              = "/ecs/${var.project_name}"
  retention_in_days = 7
}

resource "aws_ecs_task_definition" "order_service_task_definition" {
  family                   = var.name[1]
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name         = var.name[1]
      image        = var.ecr_image[1]
      essential    = true
      portMappings = [{ containerPort = var.container_port[1] }]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/${var.project_name}"
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = var.project_name
        }
      }
      environment = var.environment
    }
  ])
}

resource "aws_ecs_service" "order_service_ecs_service" {
  name            = var.name[1]
  cluster         = aws_ecs_cluster.ecs_cluster.id
  desired_count   = var.desired_count
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.order_service_task_definition.arn

  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = [var.order_service_sg]
    assign_public_ip = true
  }

  service_registries {
    registry_arn = aws_service_discovery_service.order_service.arn
  }

  load_balancer {
    target_group_arn = var.alb_target_group_arn
    container_name   = var.name[1]
    container_port   = var.container_port[1]
  }
}

resource "aws_ecs_task_definition" "api_gateway_task_definition" {
  family                   = var.name[2]
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name         = var.name[2]
      image        = var.ecr_image[2]
      essential    = true
      portMappings = [{ containerPort = var.container_port[2] }]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/${var.project_name}"
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = var.project_name
        }
      }
      environment = var.environment
    }
  ])
}

resource "aws_ecs_service" "api_gateway_ecs_service" {
  name            = var.name[2]
  cluster         = aws_ecs_cluster.ecs_cluster.id
  desired_count   = var.desired_count
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.api_gateway_task_definition.arn

  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = [var.api_gateway_sg]
    assign_public_ip = true
  }

  service_registries {
    registry_arn = aws_service_discovery_service.api_gateway.arn
  }

  load_balancer {
    target_group_arn = var.alb_target_group_arn
    container_name   = var.name[2]
    container_port   = var.container_port[2]
  }
}




resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole2"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_service_discovery_private_dns_namespace" "microservices" {
  name        = "internal.local"
  description = "Private namespace for microservices"
  vpc         = var.vpc_id
}


resource "aws_service_discovery_service" "user_service" {
  name = "user-service"
  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.microservices.id
    dns_records {
      type = "A"
      ttl  = 10
    }
    routing_policy = "MULTIVALUE"
  }

}

resource "aws_service_discovery_service" "order_service" {
  name = "order-service"
  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.microservices.id
    dns_records {
      type = "A"
      ttl  = 10
    }
    routing_policy = "MULTIVALUE"
  }

}

resource "aws_service_discovery_service" "api_gateway" {
  name = "api-gateway"
  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.microservices.id
    dns_records {
      type = "A"
      ttl  = 10
    }
    routing_policy = "MULTIVALUE"
  }

}
