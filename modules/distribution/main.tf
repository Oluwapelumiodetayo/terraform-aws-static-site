terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"

      configuration_aliases = [
        aws.use1
      ]
    }
  }
}


resource "aws_acm_certificate" "this" {

  provider = aws.use1

  domain_name = var.domain_name

  validation_method = "DNS"

  subject_alternative_names = [
    "www.${var.domain_name}"
  ]

  lifecycle {
    create_before_destroy = true
  }

}


resource "aws_route53_record" "cert_validation" {

  for_each = {
    for dvo in aws_acm_certificate.this.domain_validation_options :
    dvo.domain_name => dvo
  }

  zone_id = var.zone_id

  name = each.value.resource_record_name

  type = each.value.resource_record_type

  records = [
    each.value.resource_record_value
  ]

  ttl = 60

}


resource "aws_acm_certificate_validation" "this" {

  provider = aws.use1

  certificate_arn = aws_acm_certificate.this.arn

  validation_record_fqdns = [
    for record in aws_route53_record.cert_validation :
    record.fqdn
  ]

}



resource "aws_cloudfront_distribution" "cdn" {

  enabled             = true
  default_root_object = "index.html"

  aliases = [
    "tech-projects.xyz",
    "www.tech-projects.xyz"
  ]
   
  origin {
    domain_name = var.website_endpoint
    origin_id   = "s3-origin"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols = [
        "TLSv1.2"
      ]
    }
  }

  default_cache_behavior {
    target_origin_id       = "s3-origin"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {

    acm_certificate_arn = aws_acm_certificate_validation.this.certificate_arn

    ssl_support_method = "sni-only"

    minimum_protocol_version = "TLSv1.2_2021"

  }

}



resource "aws_route53_record" "apex" {

  zone_id = var.zone_id

  name = var.domain_name

  type = "A"


  alias {

    name = aws_cloudfront_distribution.cdn.domain_name

    zone_id = aws_cloudfront_distribution.cdn.hosted_zone_id

    evaluate_target_health = false

  }

}



resource "aws_route53_record" "www" {

  zone_id = var.zone_id

  name = "www.${var.domain_name}"

  type = "A"


  alias {

    name = aws_cloudfront_distribution.cdn.domain_name

    zone_id = aws_cloudfront_distribution.cdn.hosted_zone_id

    evaluate_target_health = false

  }

}
