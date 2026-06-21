output "bucket_name" {
  value = aws_s3_bucket.this.id
}


output "bucket_domain" {
  value = aws_s3_bucket.this.bucket_regional_domain_name
}


output "website_endpoint" {
  value = aws_s3_bucket_website_configuration.this.website_endpoint
}
