locals {
  tag_url   = "https://api.github.com/repos/${var.package_repository}/tags"
  files_url = var.packages_version == "latest" ? "https://github.com/${var.package_repository}/releases/latest/download/lambda_payload_${var.runtime}_${var.architecture}.zip" : "https://github.com/${var.package_repository}/releases/download/${var.packages_version}/lambda_payload_${var.runtime}_${var.architecture}.zip"
}

data "http" "this" {
  url = local.tag_url
}

data "local_file" "this" {
  filename = "${path.module}/../payloads/lambda_payload_${var.runtime}_${var.architecture}.zip"
  depends_on = [
    null_resource.this
  ]
}
