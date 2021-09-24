/*
 * Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
 * SPDX-License-Identifier: MIT-0
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this
 * software and associated documentation files (the "Software"), to deal in the Software
 * without restriction, including without limitation the rights to use, copy, modify,
 * merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
 * PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

variable "public_docker_repo" {}
variable "private_container_repo_url" {}
variable "image_repo_name" {
  default = "jetstack/cert-manager-controller"
}

variable "public_image_repo" {
  default = "quay.io"
}
variable "cert_manager_image_tag" {
  type        = string
  default     = "v1.5.3"
  description = "Docker image tag for cert-manager controller"
}
variable "cert_manager_helm_chart_version" {
  type        = string
  default     = "0.1.0"
  description = "Helm chart version for cert-manager"
}
variable "cert_manager_install_crds" {
  type        = bool
  description = "Whether Cert Manager CRDs should be installed as part of the cert-manager Helm chart installation"
  default     = true
}