module "lambda" {
  source                  = "terraform-aws-modules/lambda/aws"
  version = "7.4.0"
  #
  function_name           = var.AWS_LAMBDA_NAME
  description             = "First Build Lambda Round"
  handler                 = var.AWS_LAMBDA_HANDLER
  lambda_role             = aws_iam_role.appFunctionSession01v1_role.arn
  publish = true
  #
  memory_size             = var.AWS_LAMBDA_MEMORY_SIZE
  runtime                 = var.AWS_LAMBDA_RUNTIME
  package_type            = var.AWS_LAMBDA_PACKAGE_TYPE
  architectures           = var.AWS_LAMBDA_ARCHITECTURES # arm64
  #
  create_package          = false
  local_existing_package = local.filename
  # source_code_hash       = base64sha256(local.filename)
  ignore_source_code_hash = true
  tags                    = local.common_tags

  # role_permissions_boundary = ""

  # When the Lambda function is created with publish = true
  # the new version is automatically increased and a qualified identifier (version number)
  # becomes available and will be used when setting Lambda permissions.
  # publish = true

}
