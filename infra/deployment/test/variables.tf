variable "environment" {
  type        = string
  description = "Current stage of the deployment process."
  default     = "test"
}

variable "image_tag" {
  type        = string
  description = "Docker image to run in the ECS cluster"
}
