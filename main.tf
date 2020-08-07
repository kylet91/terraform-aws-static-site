module "s3cf" {
  source = "./modules/s3cf/"
  
  primary_domain = "vega.dog"
  secondary_domain = "www.vega.dog"
  cert_validation_timeout = "15m"
  s3_bucket = "prod-vega-site"
  s3_origin = "s3-ori-vega"
  cloudfront_comment = "Created using a module!"
  providers = {
    aws.useast1 = aws.useast1
  }
}
