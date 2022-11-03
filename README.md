# base-lambda-payloads

CI Creating base AWS Lambda payload for ease of use with AWS S3

# Usage

This project is made to be use in combination with terraform to provide a safe base payload for starting up AWS Lambda functions

```terraform
locals {
    tag_url = "https://api.github.com/repos/nwmqpa/base-lambda-payloads/tags"
    files_url = "https://github.com/nwmqpa/base-lambda-payloads/releases/latest/download/lambda_payload_${var.runtime}_${var.architecture}.zip"
}

data "http" "last_release_version" {
    url = local.tag_url
}

resource "null_resource" "download_file" {
    triggers = {
        latest_tag = lookup(element(jsondecode(data.http.last_release_version.response_body), 0), "name", "v0.0.0")
    }

    provisioner "local-exec" {
        command = "curl -L ${local.url} -o ${path.module}/lambda_payload_${var.runtime}_${var.architecture}.zip"
    }
}

data "local_file" "new_file" {
    filename = "${path.module}/lambda_payload_${var.runtime}_${var.architecture}.zip"
    depends_on = [
        null_resource.download_file
    ]
}

resource "aws_s3_object" "initial" {
  bucket         = "..."
  key            = "..."
  content_base64 = data.local_file.new_file.content_base64

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

## nodejs16.x

---

## x86_64

The `nodejs16.x` x86_64 payload is a zip containing an ESModule with the `index.js` file as the main handler.

```
$ echo && unzip -l lambda_payload_nodejs16.x_x86_64.zip

Archive:  lambda_payload_nodejs16x_x86_64.zip
  Length      Date    Time    Name
---------  ---------- -----   ----
  XXXXXXX  DD-MM-YYYY HH:MM   index.js
  XXXXXXX  DD-MM-YYYY HH:MM   package.json
  XXXXXXX  DD-MM-YYYY HH:MM   package-lock.json
---------                     -------
  XXXXXXX                     3 file

```

## arm64

The `nodejs16.x` arm64 payload is a zip containing an ESModule with the `index.js` file as the main handler.

```
$ echo && unzip -l lambda_payload_nodejs16x_arm64.zip

Archive:  lambda_payload_nodejs16x_arm64.zip
  Length      Date    Time    Name
---------  ---------- -----   ----
  XXXXXXX  DD-MM-YYYY HH:MM   index.js
  XXXXXXX  DD-MM-YYYY HH:MM   package.json
  XXXXXXX  DD-MM-YYYY HH:MM   package-lock.json
---------                     -------
  XXXXXXX                     3 file

```

## nodejs14.x

---

## x86_64

The `nodejs14.x` x86_64 payload is a zip containing an ESModule with the `index.js` file as the main handler.

```
$ echo && unzip -l lambda_payload_nodejs14.x_x86_64.zip

Archive:  lambda_payload_nodejs14.x_x86_64.zip
  Length      Date    Time    Name
---------  ---------- -----   ----
  XXXXXXX  DD-MM-YYYY HH:MM   index.js
  XXXXXXX  DD-MM-YYYY HH:MM   package.json
  XXXXXXX  DD-MM-YYYY HH:MM   package-lock.json
---------                     -------
  XXXXXXX                     3 file

```

## arm64

The `nodejs14.x` arm64 payload is a zip containing an ESModule with the `index.js` file as the main handler.

```
$ echo && unzip -l lambda_payload_nodejs14.x_arm64.zip

Archive:  lambda_payload_nodejs14.x_arm64.zip
  Length      Date    Time    Name
---------  ---------- -----   ----
  XXXXXXX  DD-MM-YYYY HH:MM   index.js
  XXXXXXX  DD-MM-YYYY HH:MM   package.json
  XXXXXXX  DD-MM-YYYY HH:MM   package-lock.json
---------                     -------
  XXXXXXX                     3 file

```

## nodejs12.x

---

## x86_64

The `nodejs12.x` x86_64 payload is a zip containing an ESModule with the `index.js` file as the main handler.

```
$ echo && unzip -l lambda_payload_nodejs12.x_x86_64.zip

Archive:  lambda_payload_nodejs12.x_x86_64.zip
  Length      Date    Time    Name
---------  ---------- -----   ----
  XXXXXXX  DD-MM-YYYY HH:MM   index.js
  XXXXXXX  DD-MM-YYYY HH:MM   package.json
  XXXXXXX  DD-MM-YYYY HH:MM   package-lock.json
---------                     -------
  XXXXXXX                     3 file

```

## arm64

The `nodejs12.x` arm64 payload is a zip containing an ESModule with the `index.js` file as the main handler.

```
$ echo && unzip -l lambda_payload_nodejs12.x_arm64.zip

Archive:  lambda_payload_nodejs12.x_arm64.zip
  Length      Date    Time    Name
---------  ---------- -----   ----
  XXXXXXX  DD-MM-YYYY HH:MM   index.js
  XXXXXXX  DD-MM-YYYY HH:MM   package.json
  XXXXXXX  DD-MM-YYYY HH:MM   package-lock.json
---------                     -------
  XXXXXXX                     3 file

```
