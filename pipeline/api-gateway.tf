#Variable for this file, used to determine when apig changes are made to redeploy the api gateway stage
variable "apiGatewayTerraformFile" {
  default = "../pipeline/api-gateway.tf"
}

#API Gateway config
resource "aws_api_gateway_rest_api" "api_gateway_rest_api" {
  name = "${var.api_gateway_name}"
}

#Greedy path endpoint definition - Greedy path will handle all requests for all subpaths
resource "aws_api_gateway_resource" "greedy_path_resource" {
  rest_api_id = "${aws_api_gateway_rest_api.api_gateway_rest_api.id}"
  parent_id = "${aws_api_gateway_rest_api.api_gateway_rest_api.root_resource_id}"
  path_part = "{proxy+}"
}

#Allow any method for stage/* path
resource "aws_api_gateway_method" "greedy_path_method" {
  rest_api_id = "${aws_api_gateway_rest_api.api_gateway_rest_api.id}"
  resource_id = "${aws_api_gateway_resource.greedy_path_resource.id}"
  http_method = "ANY"
  authorization = "NONE"
}

#Connect api gateway /* path with lambda
resource "aws_api_gateway_integration" "api_integration" {
  rest_api_id             = "${aws_api_gateway_rest_api.api_gateway_rest_api.id}"
  resource_id             = "${aws_api_gateway_resource.greedy_path_resource.id}"
  http_method             = "${aws_api_gateway_method.greedy_path_method.http_method}"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${aws_lambda_function.api_lambda_function.invoke_arn}"
}

#Permission to execute lambda from api gateway event
resource "aws_lambda_permission" "apig_lambda" {
  action = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.api_lambda_function.arn}"
  principal = "apigateway.amazonaws.com"
  statement_id = "AllowExecutionFromAPIGateway"
  source_arn = "arn:aws:execute-api:${var.region}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.api_gateway_rest_api.id}/*/*/*"
}

#Stage definition
resource "aws_api_gateway_deployment" "apig_deployment" {
  depends_on = ["aws_api_gateway_integration.api_integration"]
  rest_api_id = "${aws_api_gateway_rest_api.api_gateway_rest_api.id}"
  stage_name = "${var.stage}"
  stage_description = "${base64sha256(file(var.apiGatewayTerraformFile))}" #This is important, it will cause the stage to get deployed if this file is changed.  If it is not present the stage will not get updated even on dependent apig resource changes.
}

#Display the invoke url in the terminal
output "display_invoke_url" {
  value = "Invoke URL: ${aws_api_gateway_deployment.apig_deployment.invoke_url}${aws_api_gateway_resource.greedy_path_resource.path}"
}