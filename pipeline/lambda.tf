
#Lambda function
resource "aws_lambda_function" "api_lambda_function" {
  filename = "Lambda-build.zip"
  function_name = "${var.lambda_name}"
  handler = "switchboard.handler"
  timeout = 5
  memory_size = 128
  role = "${aws_iam_role.lambda_execution_role.arn}"
  runtime = "python3.6.0"
  source_code_hash = "${base64sha256(file("Lambda-build.zip"))}"
}
