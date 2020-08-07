output "bucket_endpoint" {
  value       = aws_s3_bucket.bucket-s3cf.website_endpoint
  description = "The endpoint of the AWS Bucket"
}

output "cloudfront_domain_name" {
  value       = aws_cloudfront_distribution.cloudfront-s3cf.domain_name
  description = "The domain Cloudfront returned"
}

output "route53_nameservers" {
  value       = data.aws_route53_zone.domain-s3cf.name_servers
  description = "The nameservers route53 has provided"
}
