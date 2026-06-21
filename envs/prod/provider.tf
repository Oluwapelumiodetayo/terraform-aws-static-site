terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket         = "tf-state-160823835026-nigeria"
    key            = "envs/prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tf-lock"
    encrypt        = true
  }
}


provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias  = "use1"
  region = "us-east-1"
}
