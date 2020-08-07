resource "aws_acm_certificate" "cert-s3cf" {
  domain_name       = var.primary_domain
  validation_method = "DNS"
  provider          = aws.useast1

  subject_alternative_names = ["${var.secondary_domain}"]

}

resource "aws_route53_record" "cert_validation-s3cf" {
  name    = aws_acm_certificate.cert-s3cf.domain_validation_options.0.resource_record_name
  type    = aws_acm_certificate.cert-s3cf.domain_validation_options.0.resource_record_type
  zone_id = data.aws_route53_zone.domain-s3cf.zone_id
  records = ["${aws_acm_certificate.cert-s3cf.domain_validation_options.0.resource_record_value}"]
  ttl     = 60
}

resource "aws_route53_record" "cert_validation-www-s3cf" {
  name    = aws_acm_certificate.cert-s3cf.domain_validation_options.1.resource_record_name
  type    = aws_acm_certificate.cert-s3cf.domain_validation_options.1.resource_record_type
  zone_id = data.aws_route53_zone.domain-s3cf.zone_id
  records = ["${aws_acm_certificate.cert-s3cf.domain_validation_options.1.resource_record_value}"]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = aws_acm_certificate.cert-s3cf.arn
  validation_record_fqdns = ["${aws_route53_record.cert_validation-s3cf.fqdn}", "${aws_route53_record.cert_validation-www-s3cf.fqdn}"]
  provider                = aws.useast1
  timeouts {
    create = var.cert_validation_timeout
  }
}
