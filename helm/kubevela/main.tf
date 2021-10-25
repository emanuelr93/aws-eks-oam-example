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

locals {
  image_url = var.public_docker_repo ? var.kubevela_image : "${var.private_container_repo_url}${var.kubevela_image}"
}

resource "kubernetes_namespace" "kubevela_system" {
  metadata {
    name = "vela-system"
  }
}
#Workaround for issue https://github.com/hashicorp/terraform-provider-helm/issues/707
resource "helm_release" "kubevela" {
  name       = "vela-core"
  #repository = "https://charts.kubevela.net/core"
  chart      = "https://kubevelacharts.oss-cn-hangzhou.aliyuncs.com/core/vela-core-${var.kubevela_helm_chart_version}.tgz"
  #version    = var.kubevela_helm_chart_version
  namespace  = kubernetes_namespace.kubevela_system.id
  timeout    = "1200"
  values = [templatefile("${path.module}/templates/kubevela-values.yaml", {
    image = local.image_url
    tag                                     = var.kubevela_image_tag
  })]
}

