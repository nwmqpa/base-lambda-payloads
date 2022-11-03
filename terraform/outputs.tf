output "filename" {
  value       = data.local_file.this.filename
  description = "Path to the base function package that will be read."
}

output "content_base64" {
  value       = data.local_file.this.content_base64
  description = "Base64 of the base function package that will be read."
}
