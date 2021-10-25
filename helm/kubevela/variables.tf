
variable "kubevela_image_tag" {
  default     = "v1.1.6"
  description = "Docker image tag for kubevela"
}

variable "kubevela_image" {
  default     = "oamdev/vela-core"
  description = "Docker image for kubevela"
}

variable "kubevela_helm_chart_version" {
  default     = "1.1.6"
  description = "Helm chart version for kubevela"
}

variable "kubevela_helm_chart" {
  default     = "kubevela/vela-core"
  description = "Helm chart for kubevela"
}

variable "private_container_repo_url" {}

variable "public_docker_repo" {}
