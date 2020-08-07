data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.bucket-s3cf.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.s3cfdog-oai.iam_arn]
    }
  }

  statement {
    actions   = ["s3:ListBucket"]
    resources = [aws_s3_bucket.bucket-s3cf.arn]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.s3cfdog-oai.iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "prod-s3cf-policy" {
  bucket = aws_s3_bucket.bucket-s3cf.id
  policy = data.aws_iam_policy_document.s3_policy.json
}
