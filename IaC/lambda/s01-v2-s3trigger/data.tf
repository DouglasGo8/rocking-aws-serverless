data "aws_iam_policy_document" "appFunctionSession01v1_assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "appFunctionSession01v1_cloudwatch_role_policy_document" {
  statement {
    effect  = "Allow"
    actions = [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:CopyObject",
      "s3:HeadObject",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [aws_cloudwatch_log_group.appFunctionSession01v1_log_group.arn]
  }

  statement {
    effect    = "Allow"
    actions   = ["logs:PutLogEvents"]
    resources = ["${aws_cloudwatch_log_group.appFunctionSession01v1_log_group.arn}:*"]
  }

}