variable "region" {
  default = "us-west-2"
}

data "aws_caller_identity" "current" {}

provider "aws" {
  region = "${var.region}"
  access_key = "AKIAJLLVUAZ6XKN3OFGA"
  secret_key = "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"
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

terraform remote config {
  backend "s3" {
    bucket = "serverless-lambda-b"
    key    = "circle_demo"
    region = "us-west-2"
    profile = "sabarish" 
  }
}
