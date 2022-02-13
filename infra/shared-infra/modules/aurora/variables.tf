variable "environment" {
  type        = string
  description = "Which stage we currently add."
}

variable "aurora_cluster_master_username" {
    type = string
}

variable "aurora_cluster_master_password" {
    type = string
}
