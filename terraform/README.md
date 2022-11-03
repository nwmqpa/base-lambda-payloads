# base-lambda-payload

Terraform Module to get a default packaged version of a lambda

## Usage

```terraform
module "lambda_base_source" {
    source = "github.com/nwmqpa/base-lambda-payloads/terraform"

    runtime            = "..." // Required
    architecture       = "..." // Defaults to x86_64
    package_repository = "..." // Defaults to nwmqpa/base-lambda-payloads
    packages_version   = "..." // Defaults to latest
}
```
