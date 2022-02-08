variable "environment" {
  type = string
}

variable "main_vpc_id" {
  type        = string
  description = "Main vpc id from shared infra."
}

variable "alb_security_group_id" {
  type = string
  description = "Application load balancer security group from shared infra."
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "Main vpc public subnet id from shared infra."
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "Main vpc private subnet id from shared infra."
}

variable "ecs_task_execution_role_name" {
  type        = string
  description = "ECS task execution role name"
  default     = "EcsTaskExecutionRole"
}

variable "ecs_auto_scale_role_name" {
  type        = string
  description = "ECS auto scale role Name"
  default     = "EcsAutoScaleRole"
}

variable "app_image" {
  type        = string
  description = "Docker image to run in the ECS cluster"
}

variable "repository_url" {
 type = string
 description = "Url of the repo where the image is."
}

variable "app_port" {
  type        = number
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 3000
}

variable "container_count" {
  type        = number
  description = "Number of docker containers to run"
  default     = 3
}

variable "health_check_path" {
  type    = string
  default = "/"
}

variable "fargate_cpu" {
  type        = string
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "1024"
}

variable "fargate_memory" {
  type        = string
  description = "Fargate instance memory to provision (in MiB)"
  default     = "2048"
}

variable "cluster_id" {
  type = string
}

variable "main_alb_target_group_ar" {
  type = string
}