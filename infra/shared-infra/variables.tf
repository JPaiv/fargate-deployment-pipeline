variable "environment" {
  type        = string
  description = "Which part of the development pipeline, dev, test, stage, prod etc."
}

variable "default_region" {
  type        = string
  description = "Get the default region from GHA pipeline env  variables."
}
