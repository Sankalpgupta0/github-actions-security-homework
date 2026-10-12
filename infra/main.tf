
resource "aws_s3_bucket" "homework" {
  bucket = "sankalp-gha-infra-homework-demo"
}

# Enable server-side encryption using AWS KMS
resource "aws_s3_bucket_server_side_encryption_configuration" "homework" {
  bucket = aws_s3_bucket.homework.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }

    bucket_key_enabled = true
  }
}

# Enable S3 bucket versioning
resource "aws_s3_bucket_versioning" "homework" {
  bucket = aws_s3_bucket.homework.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Block public access to the bucket
resource "aws_s3_bucket_public_access_block" "homework" {
  bucket = aws_s3_bucket.homework.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Configure a lifecycle rule to transition old objects
resource "aws_s3_bucket_lifecycle_configuration" "homework" {
  bucket = aws_s3_bucket.homework.id

  rule {
    id     = "expire-old-objects"
    status = "Enabled"

    filter {}

    expiration {
      days = 365
    }
  }
}
