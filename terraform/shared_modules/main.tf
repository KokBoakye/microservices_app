module "vpc" {
  source = "./vpc"

  vpc_cidr_block        = var.vpc_cidr_block
  public_subnets_cidrs  = var.public_subnets_cidrs[*]
  private_subnets_cidrs = var.private_subnets_cidrs[*]
  availability_zones    = var.availability_zones[*]
  name                  = var.vpc_name

}

module "alb" {
  source = "./alb"

  vpc_id         = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets
  project_name   = var.project_name

}



module "ecs" {
  source               = "./ecs"
  subnet_ids           = module.vpc.private_subnets
  alb_target_group_arn = module.alb.target_group_arn
  aws_region           = var.aws_region
  project_name         = var.project_name
  vpc_id               = module.vpc.vpc_id

}


