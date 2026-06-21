output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.cdn.domain_name
}

output "distribution_id" {
  value = aws_cloudfront_distribution.cdn.id
}

output "cloudfront_zone_id" {
  value = aws_cloudfront_distribution.cdn.hosted_zone_id
}

output "acm_certificate_arn" {
  value = aws_acm_certificate.this.arn
}

output "acm_domain_validation_options" {
  value = aws_acm_certificate.this.domain_validation_options
}
