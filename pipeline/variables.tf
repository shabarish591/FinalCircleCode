terraform {
  backend "s3" {
    bucket   = "my-nike-lambda-bucket"
    key      = "nike-lambda-project/terraform.tfstate"
    region   = "us-east-2"
  }
}

variable "stage" {
  default = "dev"
}
variable "lambda_file" {
  default = "../pipeline/lambda.zip"
}
