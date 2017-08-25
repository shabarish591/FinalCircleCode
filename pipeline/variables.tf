variable "region" {
  default = "us-west-2"
}

data "aws_caller_identity" "current" {}

provider "aws" {
  region = "${var.region}"
}

variable "lambda_file" {
  default = "../build/local-build-api.zip"
}

variable "stage" {
  default = "dev"
}

variable "lambda_name" {
  default = "SampleCircleLambda"
}

variable "api_gateway_name" {
  default = "SampleCircleProxy"
}

variable "role_name" {
  default = "SampleCircleRole"
}

terraform {
  backend "s3" {
    bucket = "ngp-terraform-remote-config"
    key    = "circle_demo"
    region = "us-west-2"
  }
}