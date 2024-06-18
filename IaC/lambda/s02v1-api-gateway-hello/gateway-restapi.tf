# https://www.bogotobogo.com/DevOps/AWS/aws-API-Gateway-Lambda-Terraform.php
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_integration
resource "aws_api_gateway_rest_api" "helloWorld_apiGateway" {
  name        = "HelloWorld-APIGateway-${random_string.random.id}"
  description = "A Simple Gateway REST API and Lambda Integration"
}

resource "aws_api_gateway_resource" "helloWorld_resourceGateway" {
  path_part   = "{${var.resource_name}+}"
  rest_api_id = aws_api_gateway_rest_api.helloWorld_apiGateway.id
  parent_id   = aws_api_gateway_rest_api.helloWorld_apiGateway.root_resource_id
}

resource "aws_api_gateway_method" "helloWorld_methodGateway" {
  authorization = "NONE"
  // Section_02_video-13
  //http_method = "GET"
  // Section_02_video-14
  http_method   = "POST"
  resource_id   = aws_api_gateway_resource.helloWorld_resourceGateway.id
  rest_api_id   = aws_api_gateway_rest_api.helloWorld_apiGateway.id
}

/*
{
  "ssn": "088-16-12AB",
  "name": "John Doe"
}
*/

resource "aws_api_gateway_integration" "helloWorld_integrationGateway" {
  rest_api_id = aws_api_gateway_rest_api.helloWorld_apiGateway.id
  resource_id = aws_api_gateway_resource.helloWorld_resourceGateway.id
  http_method = aws_api_gateway_method.helloWorld_methodGateway.http_method
  type = "AWS" // AWS_PROXY
  # Lambda function can only be invoked via POST.
  integration_http_method = "POST"
  //
  uri         = module.lambda.lambda_function_invoke_arn
  passthrough_behavior = "WHEN_NO_TEMPLATES"
  //

  // Section_02_video-13
  /*request_templates = {
    "application/json" = <<EOF
    {
      "ssn": "$input.params('ssn')",
      "name": "$input.params('name')"
    }
    EOF
  }*/

  // Section_02_video-14
  // Apache Velocity Template
  request_templates = {
    "application/json" = <<EOF
    {
      "ssn": $input.json("$.ssn"),
      "name": $input.json("$.name")
    }
    EOF
  }
}

resource "aws_api_gateway_method_response" "helloWorld_methodGatewayResponse" {
  rest_api_id = aws_api_gateway_rest_api.helloWorld_apiGateway.id
  resource_id = aws_api_gateway_resource.helloWorld_resourceGateway.id
  http_method = aws_api_gateway_method.helloWorld_methodGateway.http_method
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration_response" "helloWorld_integrationGatewayResponse" {
  rest_api_id = aws_api_gateway_rest_api.helloWorld_apiGateway.id
  resource_id = aws_api_gateway_resource.helloWorld_resourceGateway.id
  http_method = aws_api_gateway_method.helloWorld_methodGateway.http_method
  status_code = aws_api_gateway_method_response.helloWorld_methodGatewayResponse.status_code
  #
  depends_on  = [
    aws_api_gateway_integration.helloWorld_integrationGateway
  ]

  response_templates = {
    "application/json" = <<EOF
    EOF
  }
}

resource "aws_api_gateway_deployment" "helloWorld_deploymentGateway" {
  rest_api_id = aws_api_gateway_rest_api.helloWorld_apiGateway.id
  stage_name  = "dev"
  depends_on  = [
    aws_api_gateway_integration.helloWorld_integrationGateway,
    aws_api_gateway_integration_response.helloWorld_integrationGatewayResponse
  ]
}