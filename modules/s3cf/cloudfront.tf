locals {
  s3_origin_id = "s3-s3cfdog"
  ssl_arn      = aws_acm_certificate.cert-s3cf.arn
}

# Cloudfront Origin Access Identity
resource "aws_cloudfront_origin_access_identity" "s3cfdog-oai" {
  comment = "User to be allowed with S3"
}

# Cloudfront configuration
resource "aws_cloudfront_distribution" "cloudfront-s3cf" {
  origin {
    domain_name = aws_s3_bucket.bucket-s3cf.bucket_regional_domain_name
    origin_id   = local.s3_origin_id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.s3cfdog-oai.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = var.cloudfront_comment
  default_root_object = "index.html"

  logging_config {
    include_cookies = false
    bucket          = "s3cf-logs.s3.amazonaws.com"
    prefix          = "s3cflogs"
  }

  aliases = ["${var.primary_domain}"]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 600
    max_ttl                = 86400
    compress               = true
  }


  price_class = "PriceClass_All"

  restrictions {
    geo_restriction {
      restriction_type = "none"
      #      locations        = ["US", "CA", "GB", "DE"]
    }
  }

  tags = {
    Environment = "production"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
    acm_certificate_arn            = local.ssl_arn
    ssl_support_method             = "sni-only"
  }
}

