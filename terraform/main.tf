locals {
  tag_url   = "https://api.github.com/repos/${var.package_repository}/tags"
  files_url = var.version == "latest" ? "https://github.com/${var.package_repository}/releases/latest/download/lambda_payload_${var.runtime}_${var.architecture}.zip" : "https://github.com/${var.package_repository}/releases/download/${var.version}/lambda_payload_${var.runtime}_${var.architecture}.zip"
}

data "http" "this" {
  url = local.tag_url
}

resource "null_resource" "this" {
  triggers = {
    latest_tag = lookup(element(jsondecode(data.http.this.response_body), 0), "name", var.version)
  }

  provisioner "local-exec" {
    command = "curl -L ${local.url} -o ${path.module}/lambda_payload_${var.runtime}_${var.architecture}.zip"
  }
}

data "local_file" "this" {
  filename = "${path.module}/lambda_payload_${var.runtime}_${var.architecture}.zip"
  depends_on = [
    null_resource.this
  ]
}
