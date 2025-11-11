resource "aws_lb" "loadbalancer" {
  name               = var.project_name
  load_balancer_type = "application"
  subnets            = var.public_subnets[*]
  security_groups    = [aws_security_group.app_lb_sg.id]
}

resource "aws_lb_target_group" "target_group" {
  name        = var.project_name
  port        = var.port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.loadbalancer.arn
  port              = var.port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}
