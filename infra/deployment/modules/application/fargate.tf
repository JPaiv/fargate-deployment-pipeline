# Traffic to the ECS Cluster should only come from the ALB
resource "aws_security_group" "ecs_tasks_security_group" {
  name        = "${var.environment}-ecs-task"
  description = "allow inbound access from the ALB only"
  vpc_id      = var.main_vpc_id

  ingress {
    protocol        = "tcp"
    from_port       = var.app_port
    to_port         = var.app_port
    security_groups = [var.alb_security_group_id]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
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
    "image": "${var.repository_url}:${var.app_image}",
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
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.main_ecs_fargate_task-definition.arn
  desired_count   = var.container_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups = [aws_security_group.ecs_tasks_security_group.id]
    subnets         = var.private_subnet_ids
  }

  load_balancer {
    target_group_arn = var.main_alb_target_group_arn
    container_name   = "app"
    container_port   = var.app_port
  }
}
