
#Role the lambda will be executed with
resource "aws_iam_role" "lambda_execution_role" {
  name = "${var.role_name}"
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

#Allow lambda to create cloudwatch log events, equvilant to AWSLambdaBasicExecutionRole
resource "aws_iam_role_policy" "lambda_basic_execution" {
  name = "lambda_basic_execution"
  role = "${aws_iam_role.lambda_execution_role.id}"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}
