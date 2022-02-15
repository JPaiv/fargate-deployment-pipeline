resource "aws_ecs_cluster" "main_ecs_fargate_cluster" {
  name = "${var.environment}-ecs-fargate-cluster"
}
