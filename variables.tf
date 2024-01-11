# Main Variables
variable "site_region" {
  description = "The region to use."
  type        = string
  default     = "us-west-1"
}

# Domain Information

variable "site_domain" {
  description = "The domain name to be set up."
  type        = string
  default     = "fun.base7.org"
}

# Bucket Information

variable "bucket_name" {
  description = "The name of the bucket."
  type        = string
  default     = "bucket"
}

variable "bucket_acl" {
  description = "The type of ACL to use for the bucket."
  type        = string
  default     = "public-read"
}