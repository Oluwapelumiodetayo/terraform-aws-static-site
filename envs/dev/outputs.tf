output "s3_bucket_name" {
  value = module.site.bucket_name
}

output "cloudfront_url" {
  value = module.distribution.cloudfront_domain_name
}

output "site_url" {
  value = "https://${var.domain_name}"
}

output "lock_test" {
  value = "trigger-lock"
}
