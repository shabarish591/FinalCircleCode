variable "region" {
  default = "us-west-2"
}

data "aws_caller_identity" "current" {}

provider "aws" {
  region = "${var.region}"
}

variable "lambda_file" {
  default = "../build/my-build.zip"
}

variable "stage" {
  default = "dev"
}

variable "lambda_name" {
  default = "_airflow_request"
}

variable "lambda_name" {
  default = "_em7_message_check_file_system"
}

variable "lambda_name" {
  default = "_get_config_dict"
}
variable "api_gateway_name" {
  default = "MyCircleProxy"
}

variable "role_name" {
  default = "SampleCircleRole"
}

terraform {
  backend "s3" {
    bucket = "serverless-lambda-b"
    key    = "circle_demo"
    region = "us-west-2"
  }
}
