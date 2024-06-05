locals {
  owners      = var.TEAM
  environment = var.ENVIRONMENT
  name        = "${local.owners}-${local.environment}"
  filename    = "${path.module}/../../../session01-v1-simple/target/function.zip"
  common_tags = {
    owners      = local.owners
    environment = local.environment
  }
}