# Production Bucket
resource "aws_s3_bucket" "bucket-s3cf" {
  bucket        = var.s3_bucket
  acl           = "private"
  force_destroy = true
  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  tags = {
    Name        = var.primary_domain
    Environment = "Prod"
  }
  versioning {
    enabled = true
  }
}

# Logs bucket
resource "aws_s3_bucket" "bucket-s3cf-logs" {
  bucket        = "s3cf-logs"
  acl           = "private"
  force_destroy = true

  tags = {
    Name        = "s3cflogs"
    Environment = "Logs"
  }
  versioning {
    enabled = false
  }
}


# Dev Bucket
resource "aws_s3_bucket" "dev-bucket-s3cf" {
  bucket        = "dev-s3cfdog"
  acl           = "private"
  force_destroy = true
  tags = {
    Name        = "s3cfdog"
    Environment = "Dev"
  }
  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.key-dev-bucket-s3cf.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

resource "aws_kms_key" "key-dev-bucket-s3cf" {
  description             = "This key is used to encrypt bucket objects for s3cf.dog"
  deletion_window_in_days = 10
}

resource "aws_kms_alias" "alias-key-dev-bucket-s3cf" {
  name          = "alias/dev2-bucket-s3cf"
  target_key_id = aws_kms_key.key-dev-bucket-s3cf.key_id
}
