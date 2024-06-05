resource "aws_iam_role" "appFunctionSession01v1_role" {
  name               = "${var.AWS_LAMBDA_NAME}_role"
  assume_role_policy = data.aws_iam_policy_document.appFunctionSession01v1_assume_role_policy.json
  tags               = local.common_tags
}

resource "aws_cloudwatch_log_group" "appFunctionSession01v1_log_group" {
  name = "/aws/lambda/${var.AWS_LAMBDA_NAME}-log"
}

resource "aws_iam_role_policy" "appFunctionSession01v1_log_policy" {
  name   = "${var.AWS_LAMBDA_NAME}_log_policy"
  policy = data.aws_iam_policy_document.appFunctionSession01v1_cloudwatch_role_policy_document.json
  role   = aws_iam_role.appFunctionSession01v1_role.id
}
