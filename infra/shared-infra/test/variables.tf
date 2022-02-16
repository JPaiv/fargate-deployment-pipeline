variable "environment" {
  type        = string
  description = "Which part of the development pipeline, dev, test, stage, prod etc."
}

variable "default_region" {
  type        = string
  description = "Get the default region from GHA pipeline enV variables."
}

variable "aurora_master_username" {
  type = string
  default = "moviemasteruser"
}