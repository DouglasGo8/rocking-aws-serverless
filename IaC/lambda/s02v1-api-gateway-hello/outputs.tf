output "base_url" {
  value = "${aws_api_gateway_deployment.helloWorld_deploymentGateway.invoke_url}/${var.resource_name}"
}