provider "aws" {
	region = "us-west-2"
}

resource "aws_lambda_function" "Test_airflow_request" {
  filename = "${var.lambda_file}"
  function_name = "T_airflow_request"
  handler = "switchboard.handler"
  runtime = "python2.7"
  role = "${aws_iam_role.lambda_execution_role.arn}"
  source_code_hash = "${base64sha256(file(var.lambda_file))}"
}

resource "aws_iam_role" "lambda_execution_role" {
 assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}


