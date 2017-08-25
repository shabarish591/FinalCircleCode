
#Lambda function
resource "aws_lambda_function" "_airflow_request" {
  filename = "${var.lambda_file}"
  function_name = "${var.lambda_name}"
  handler = "switchboard.handler"
  timeout = 5
  memory_size = 128
  role = "${aws_iam_role.lambda_execution_role.arn}"
  runtime = "python3.6.0"
  source_code_hash = "${var.lambda_file}.output_base64sha256}"
}

