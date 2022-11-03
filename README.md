# base-lambda-payloads

CI Creating base AWS Lambda payload for ease of use with AWS S3

# Usage

This project is made to be use in combination with terraform to provide a safe base payload for starting up AWS Lambda functions

```terraform
data "http" "lambda_base_payload" {
  url = "https://github.com/nwmqpa/base-lambda-payloads/releases/latest/download/lambda_payload_${var.runtime}_${var.architecture}.zip"
}

resource "aws_s3_object" "initial" {
  bucket         = "..."
  key            = "..."
  content_base64 = textencodebase64(data.http.lambda_base_payload.response_body, "US-ASCII")

  lifecycle {
    ignore_changes = [
      content_base64
    ]
  }
}

resource "aws_lambda_function" "this" {
  function_name = "..."
  handler       = "..." // To configure using the handler configuration in the payload file
  runtime       = var.runtime
  architectures = [var.architecture]
  s3_bucket     = aws_s3_object.initial.bucket
  s3_key        = aws_s3_object.initial.key
}
```

## go1.x

---

## x86_64

The `go1.x` x86_64 payload is a zip containing a single `main` file responsible for handling the lambda logic.

```
$ echo && unzip -l lambda_payload_go.1x_x86_64.zip

Archive:  lambda_payload_go.1x_x86_64.zip
  Length      Date    Time    Name
---------  ---------- -----   ----
  XXXXXXX  DD-MM-YYYY HH:MM   main
---------                     -------
  XXXXXXX                     1 file

```

## arm64

The `go1.x` arm64 payload is a zip containing a single `bootstrap` file responsible for handling the lambda logic.

> **_IMPORTANT:_** As of writing, the `go.1x` runtime does not yet support arm64. You must use the `provided.al2` runtime

```
$ echo && unzip -l lambda_payload_go.1x_arm64.zip

Archive:  lambda_payload_go.1x_arm64.zip
  Length      Date    Time    Name
---------  ---------- -----   ----
  XXXXXXX  DD-MM-YYYY HH:MM   bootstrap
---------                     -------
  XXXXXXX                     1 file

```
