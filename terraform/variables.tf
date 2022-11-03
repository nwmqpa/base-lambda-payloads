variable "runtime" {
  type        = string
  description = "Runtime on which the base lambda package will be fetched"
}

variable "architecture" {
  type        = string
  description = "Architecture on which the base lambda package will be fetched"
  default     = "x86_64"

  validation {
    condition     = contains(["x86_64", "arm64"], var.architecture)
    error_message = "Architecture ${var.architecture} is not contained in the set [\"x86_64\", \"arm64\"]"
  }
}

variable "package_repository" {
  type        = string
  description = "Repository containing the different base functions packages"
  default     = "nwmqpa/base-lambda-payloads"

  validation {
    condition     = length(regexall("^[^/]+/[^/]+$", var.package_repository)) > 0
    error_message = "Package repository \"${var.package_repository}\" is not of the form \"(USER|ORGA)/REPOSITORY\""
  }
}

variable "packages_version" {
  type        = string
  description = "Version used in the package_repository. Use \"latest\" for the latest release"
  default     = "latest"
}
