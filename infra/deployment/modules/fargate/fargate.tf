resource "aws_security_group" "alb_security_group" {
  name        = "${var.environment}-alb-security-group"
  description = "controls access to the ALB"
  vpc_id      = var.main_vpc_id

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Traffic to the ECS Cluster should only come from the ALB
resource "aws_security_group" "ecs_tasks_security_group" {
  name        = "${var.environment}-ecs-task"
  description = "allow inbound access from the ALB only"
  vpc_id      = var.main_vpc_id

  ingress {
    protocol        = "tcp"
    from_port       = var.app_port
    to_port         = var.app_port
    security_groups = [aws_security_group.alb_security_group.id]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

### ALB

resource "aws_alb" "main_alb" {
  name            = "${var.environment}-main-alb"
  subnets         = var.public_subnet_ids
  security_groups = ["${aws_security_group.alb_security_group.id}"]
}

resource "aws_alb_target_group" "main_alb_target_group" {
  name        = "${var.environment}-main-alb-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.main_vpc_id
  target_type = "ip"
}

# Redirect all traffic from the ALB to the target group
resource "aws_alb_listener" "front_end_alb_listener" {
  load_balancer_arn = aws_alb.main_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.main_alb_target_group.id
    type             = "forward"
  }
}

### ECS

resource "aws_ecs_cluster" "main_ecs_fargate_cluster" {
  name = "${var.environment}-ecs-fargate-cluster"
}

resource "aws_ecs_task_definition" "main_ecs_fargate_task-definition" {
  family                   = "${var.environment}-ecs-fargate-task-definition"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory

  container_definitions = <<DEFINITION
[
  {
    "cpu": ${var.fargate_cpu},
    "image": "${var.app_image}",
    "memory": ${var.fargate_memory},
    "name": "app",
    "networkMode": "awsvpc",
    "portMappings": [
      {
        "containerPort": ${var.app_port},
        "hostPort": ${var.app_port}
      }
    ]
  }
]
DEFINITION
}

resource "aws_ecs_service" "main" {
  name            = "${var.environment}-fargate-ecs-service"
  cluster         = aws_ecs_cluster.main_ecs_fargate_cluster.id
  task_definition = aws_ecs_task_definition.main_ecs_fargate_task-definition.arn
  desired_count   = var.container_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups = [aws_security_group.ecs_tasks_security_group.id]
    subnets         = var.private_subnet_ids
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.main_alb_target_group.arn
    container_name   = "app"
    container_port   = var.app_port
  }

  depends_on = [
    aws_alb_listener.front_end_alb_listener,
  ]
}
