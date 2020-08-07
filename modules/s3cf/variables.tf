variable "primary_domain" {
  type = string
}

variable "secondary_domain" {
  type    = string
}

variable "cert_validation_timeout" {
  type    = string
  default = "20m"
}

variable "s3_bucket" {
  type    = string
  default = "prod-bucket"
}

variable "s3_origin" {
  type    = string
  default = "s3-default-ori"
}

variable "cloudfront_comment" {
  type    = string
  default = "My Cloudfront Service"
}

