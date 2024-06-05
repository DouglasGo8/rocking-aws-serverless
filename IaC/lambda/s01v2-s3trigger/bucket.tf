resource "aws_s3_bucket" "rocking-serverless-bucket-trigger" {
  bucket        = var.BUCKET_NAME
  force_destroy = true
  #
  tags          = local.common_tags
}

#resource "aws_s3_bucket_acl" "bucket_notification_permission" {
#  bucket = aws_s3_bucket.rocking-serverless-bucket-trigger.id
#  acl    = "private"
#}

resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.rocking-serverless-bucket-trigger.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_notification" "bucket_notification_lambda_trigger" {
  bucket = aws_s3_bucket.rocking-serverless-bucket-trigger.id

  lambda_function {
    lambda_function_arn = module.lambda.lambda_function_arn
    events        = ["s3:ObjectCreated:*"]
    filter_suffix = ".txt"
  }

  depends_on = [aws_lambda_permission.allow_bucket]
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda.lambda_function_arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.rocking-serverless-bucket-trigger.arn
}