locals {
  owners      = var.TEAM
  environment = var.ENVIRONMENT
  name        = "${local.owners}-${local.environment}"
  filename    = "${path.module}/../../../lambda-session01-v1/target/function.zip"
  common_tags = {
    owners      = local.owners
    environment = local.environment
  }
}