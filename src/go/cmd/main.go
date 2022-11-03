package main

import (
	"github.com/aws/aws-lambda-go/lambda"
)

func handleRequest() (string, error) {
	return "Hello World!", nil
}

func main() {
	lambda.Start(handleRequest)
}
