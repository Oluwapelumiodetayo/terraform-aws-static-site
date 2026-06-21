module "site" {
  source = "../../modules/site"

  bucket_name = "my-terraform-site-2026-oluwapelumi"
}


module "distribution" {
  source = "../../modules/distribution"

  domain_name = var.domain_name

  zone_id = aws_route53_zone.main.zone_id

  bucket_domain_name = module.site.bucket_domain

  website_endpoint = module.site.website_endpoint


  aliases = [
    "tech-projects.xyz",
    "www.tech-projects.xyz"
  ]


  providers = {
    aws.use1 = aws.use1
  }
}
