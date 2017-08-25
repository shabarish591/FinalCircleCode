variable "region" {
  default = "us-east-2"
}

data "aws_caller_identity" "current" {}

provider "aws" {
  region = "${var.region}"
}

variable "stage" {
  default = "dev"
}

variable "lambda_file" {
  default = "lambda-build.zip"
}

variable "lambda_name" {
  default = "_airflow_request"
}

variable "api_gateway_name" {
  default = "MyCircleProxy"
}

variable "role_name" {
  default = "support-circle-ci"
}

terraform {
  backend "s3" {
    bucket = "serverless-lambda-b"
    key    = "circle_demo"
    region = "us-east-2"
  }
}
