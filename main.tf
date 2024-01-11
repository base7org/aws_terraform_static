terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.31.0"
    }
  }
}

provider "aws" {
  region  = var.site_region
  version = "5.31.0"
}

resource "aws_route53_zone" "site_zone" {
  name = var.site_domain
}

resource "aws_s3_bucket" "site_bucket" {
  bucket = "${var.bucket_name}.${var.site_domain}"
  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

resource "aws_s3_object" "site_index-page" {
  bucket       = aws_s3_bucket.site_bucket.id
  key          = "index.html"
  source       = "www-files/index.html"
  content_type = "text/html"
  acl          = var.bucket_acl
  depends_on   = [aws_s3_bucket_acl.site_bucket_acl]
}

resource "aws_s3_object" "site_error-page" {
  bucket       = aws_s3_bucket.site_bucket.id
  key          = "error.html"
  source       = "www-files/error.html"
  content_type = "text/html"
  acl          = var.bucket_acl
  depends_on   = [aws_s3_bucket_acl.site_bucket_acl]
}

resource "aws_s3_bucket_acl" "site_bucket_acl" {
  bucket     = aws_s3_bucket.site_bucket.id
  acl        = var.bucket_acl
  depends_on = [aws_s3_bucket_ownership_controls.site_bucket_acl_ownership]
}

resource "aws_s3_bucket_ownership_controls" "site_bucket_acl_ownership" {
  bucket = aws_s3_bucket.site_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
  depends_on = [aws_s3_bucket_public_access_block.site_bucket_public-access]
}

resource "aws_s3_bucket_public_access_block" "site_bucket_public-access" {
  bucket                  = aws_s3_bucket.site_bucket.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_route53_record" "site_bucket-domain_record" {
  zone_id = aws_route53_zone.site_zone.zone_id
  name    = aws_s3_bucket.site_bucket.bucket
  type    = "A"
  alias {
    name                   = aws_s3_bucket.site_bucket.website_endpoint
    zone_id                = aws_s3_bucket.site_bucket.hosted_zone_id
    evaluate_target_health = true
  }
}