variable "environment" {
  type        = string
  description = "Current stage of the deployment process."
  default     = "test"
}

variable "default_region" {
  type        = string
  description = "The AWS region things are created in"
  default     = "eu-west-1"
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

variable "image_tag" {
  type        = string
  description = "Docker image to run in the ECS cluster"
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
