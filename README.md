# Terraform AWS Static Site (Astro Blog Deployment)

## Overview
This project is a production-style Infrastructure as Code (IaC) deployment of a static Astro blog using Terraform on AWS.

It provisions and manages a complete AWS architecture including S3 for static hosting, CloudFront for global CDN distribution, Route 53 for DNS, ACM for SSL/TLS certificates, and DynamoDB-backed Terraform state locking for safe collaboration and state integrity.

The infrastructure is fully automated using Terraform and demonstrates a real-world deployment workflow with remote state management and distributed locking.

## Live Website
https://tech-projects.xyz  
https://www.tech-projects.xyz  
CloudFront URL: https://d2e09s3xe698mj.cloudfront.net  
S3 Bucket: my-terraform-site-2026-oluwapelumi  

## What I Built
I deployed a static Astro blog using Terraform by provisioning an S3 bucket for static hosting, uploading build artifacts to S3, configuring bucket policies for public access, setting up a CloudFront distribution for CDN delivery, managing DNS with Route 53, and securing the site using AWS ACM for HTTPS encryption.

I also implemented Terraform remote state management using S3 and enabled DynamoDB state locking to prevent concurrent state corruption during infrastructure changes.

## Architecture
Route 53 (DNS) → CloudFront (CDN) → S3 Bucket (Astro Build) → Users  
ACM Certificate → CloudFront (HTTPS Security Layer)  
Terraform State → S3 Backend + DynamoDB Lock Table  

## Tech Stack
Terraform, AWS S3, CloudFront, Route 53, ACM, DynamoDB, Astro, Linux (Ubuntu), Git, GitHub

## Terraform Workflow Used
terraform init  
terraform plan  
terraform apply  
terraform destroy  
terraform apply  

This confirms that the infrastructure is fully reproducible and can be safely destroyed and redeployed at any time.

## AWS Services Used
S3 Bucket: Hosts the static website files  
CloudFront: Provides global CDN and caching  
Route 53: Manages DNS for tech-projects.xyz and www.tech-projects.xyz  
ACM (AWS Certificate Manager): Provides SSL/TLS encryption with DNS validation  
DynamoDB: Used for Terraform state locking to prevent concurrent modifications  

## Terraform State Management (Important)
This project uses remote state stored in S3 with DynamoDB locking enabled.

S3 stores the Terraform state file  
DynamoDB ensures only one Terraform operation can modify state at a time  
State is encrypted and versioned for safety  

Backend configuration:

backend "s3" {
  bucket         = "tf-state-160823835026-nigeria"
  key            = "envs/dev/terraform.tfstate"
  region         = "us-east-1"
  dynamodb_table = "tf-lock"
  encrypt        = true
}

## How We Tested State Locking
To validate DynamoDB locking:

Two terminal sessions were opened in envs/dev  
Terminal 1 ran terraform apply and acquired the lock  
Terminal 2 attempted terraform apply and was blocked  
Terraform displayed lock information including Lock ID and operation details  
Terminal 1 completed or exited, releasing the lock  
Terminal 2 resumed execution after lock release  

This confirmed that Terraform state locking prevents race conditions and concurrent infrastructure updates.

## Key Outputs from Terraform
cloudfront_url = "d2e09s3xe698mj.cloudfront.net"  
s3_bucket_name = "my-terraform-site-2026-oluwapelumi"  
site_url = "https://tech-projects.xyz"  

## Key Learnings
Infrastructure as Code ensures repeatable deployments  
S3 provides scalable static hosting  
CloudFront improves global performance and latency  
Route 53 enables DNS routing to AWS resources  
ACM certificates require DNS validation before use  
Terraform remote state ensures consistency across environments  
DynamoDB locking prevents race conditions in team environments  
Proper state management is essential for production systems  

## Notes
Terraform state files are excluded from version control for security  
ACM certificates for CloudFront must be created in us-east-1  
Route 53 nameservers must be updated at the domain registrar  
CloudFront propagation may take a few minutes globally  
This infrastructure can be recreated entirely using Terraform
