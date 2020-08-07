data "aws_route53_zone" "domain-s3cf" {
  name = var.primary_domain
}

resource "aws_route53_record" "record-s3cf" {
  zone_id = data.aws_route53_zone.domain-s3cf.zone_id
  name    = var.primary_domain
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cloudfront-s3cf.domain_name
    zone_id                = aws_cloudfront_distribution.cloudfront-s3cf.hosted_zone_id
    evaluate_target_health = "true"
  }
}

resource "aws_route53_record" "record-www-s3cf" {
  zone_id = data.aws_route53_zone.domain-s3cf.zone_id
  name    = var.secondary_domain
  type    = "CNAME"
  ttl     = "300"
  records = ["${var.primary_domain}"]
}
