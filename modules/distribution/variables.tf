variable "bucket_domain_name" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "zone_id" {
  type = string
}

variable "website_endpoint" {
  type = string
}

variable "aliases" {
  type = list(string)
}
