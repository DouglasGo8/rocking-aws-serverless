variable "AWS_LAMBDA_NAME" {
  type    = string
  default = "appFunctionSession01v1"
}

variable "AWS_LAMBDA_RUNTIME" {
  type    = string
  default = "provided.al2"
}

variable "AWS_LAMBDA_HANDLER" {
  type    = string
  default = "io.quarkus.amazon.lambda.runtime.QuarkusStreamHandler::handleRequest"
}

variable "AWS_LAMBDA_MEMORY_SIZE" {
  type    = number
  default = 128
}

variable "AWS_LAMBDA_ARCHITECTURES" {
  type    = list(string)
  default = ["arm64"]
}

variable "AWS_LAMBDA_PACKAGE_TYPE" {
  type    = string
  default = "Zip"
}
#

variable "TEAM" {
  type    = string
  default = "DevConfAccount"
}

variable "ENVIRONMENT" {
  type    = string
  default = "MacOSM1Max_local"
}
