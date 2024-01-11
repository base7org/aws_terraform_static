output "hosted_zone" {
  description = "The hosted zone for the site."
  value       = aws_route53_zone.site_zone.name
}

output "bucket_domain" {
  description = "The domain being used by the bucket."
  value       = aws_s3_bucket.site_bucket.bucket
}

output "bucket_endpoint" {
  description = "The S3 endpoint for the bucket."
  value       = aws_s3_bucket.site_bucket.website_endpoint
}