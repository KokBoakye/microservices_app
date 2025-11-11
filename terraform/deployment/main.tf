module "vpc" {
  source = "../modules/vpc"

  vpc_cidr_block        = var.vpc_cidr_block
  public_subnets_cidrs  = var.public_subnets_cidrs[*]
  private_subnets_cidrs = var.private_subnets_cidrs[*]
  availability_zones    = var.availability_zones[*]
  name                  = var.vpc_name

}

module "alb" {
  source = "../modules/alb"

  vpc_id         = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets
  project_name   = var.project_name

}

module "ecr" {
  source = "../modules/ecr"

  name = var.name

}

module "ecs" {
  source = "../modules/ecs"

  name                 = var.name[*]
  container_port       = var.container_port[*]
  ecr_image            = var.ecr_image
  subnet_ids           = module.vpc.public_subnets
  alb_target_group_arn = module.alb.target_group_arn
  aws_region           = var.aws_region
  cpu                  = var.cpu
  memory               = var.memory
  desired_count        = var.desired_count
  user_service_sg      = module.alb.user_service_sg_id
  order_service_sg     = module.alb.order_service_sg_id
  api_gateway_sg       = module.alb.api_gateway_sg_id
  project_name         = var.project_name

}





