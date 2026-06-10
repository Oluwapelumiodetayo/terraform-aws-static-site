# Astro Blog Deployment with Terraform (AWS S3 + CloudFront + Route53 + ACM)

## Overview
This project is a real-world Infrastructure as Code (IaC) deployment of a static Astro blog using Terraform on AWS. It provisions and manages multiple AWS services including S3 for static website hosting, CloudFront for global CDN distribution, Route53 for DNS management, and ACM for SSL/TLS certificates. The infrastructure is fully automated using Terraform and demonstrates a complete production-style deployment workflow.

The site is currently live and accessible via a custom domain configured through Route53 and CloudFront.

## Live Website
https://tech-projects.xyz  
https://www.tech-projects.xyz  
CloudFront URL: https://ddbqgnp3himrp.cloudfront.net  
S3 Bucket: my-terraform-site-2026-oluwapelumi  

## What I Built
I deployed a static Astro blog using Terraform by creating an AWS S3 bucket for static hosting, uploading the Astro build output to S3, configuring S3 bucket policies for public access, setting up a CloudFront distribution for CDN delivery, registering and managing a custom domain using Route53, and securing the site using AWS ACM for HTTPS encryption. I also handled DNS validation for the domain and linked it to CloudFront using Route53 alias records. All infrastructure was fully automated using Terraform.

## Architecture
Route53 (DNS) → CloudFront CDN → S3 Bucket (Astro Build) → Internet Users  
ACM Certificate → CloudFront (HTTPS Security Layer)

## Tech Stack
Terraform, AWS S3, AWS CloudFront, AWS Route53, AWS ACM, Astro, Linux (Ubuntu), Git, GitHub

## Terraform Workflow Used
terraform init  
terraform plan  
terraform apply  
terraform destroy  
terraform apply  

This confirmed that the infrastructure is fully reproducible and can be destroyed and redeployed at any time using Terraform.

## AWS Services Used
S3 Bucket: Hosts the static Astro website files  
CloudFront: Provides global CDN and caching  
Route53: Manages domain (tech-projects.xyz) and DNS records  
ACM (AWS Certificate Manager): Provides SSL certificate for HTTPS  
Terraform: Automates provisioning and management of all resources  

## Key Outputs from Terraform
cloudfront_url = "ddbqgnp3himrp.cloudfront.net"  
s3_bucket_name = "my-terraform-site-2026-oluwapelumi"  
route53_zone = "tech-projects.xyz"  

## Key Learnings
Infrastructure as Code ensures repeatable and consistent deployments across environments. Route53 enables domain management and DNS routing to AWS resources. ACM certificates must be validated via DNS before CloudFront can use custom domains. CloudFront improves global performance and reduces latency. S3 provides scalable static hosting. Terraform state tracks real infrastructure and ensures consistency between configuration and deployed resources. The plan, apply, and destroy workflow validates infrastructure reliability and reproducibility.

## Notes
Terraform state files are excluded from version control for security reasons. ACM certificates must be created in us-east-1 for CloudFront compatibility. Route53 nameservers must be updated at the domain registrar (Namecheap) for DNS to work correctly. CloudFront deployments may take a few minutes to fully propagate globally. All infrastructure in this project is fully managed using Terraform and can be recreated from scratch using the same configuration.
