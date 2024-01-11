# aws_static_site

This is not the first nor will it be the last of its kind which uses Terraform to create and manage AWS resources and assets. This 'tool' (for lack of a better term) will set up everything needed to host a static website with AWS S3.

## Prerequisites
- [You must have aws-cli and its own prerequisites installed.](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- [You must have aws-cli is configured with the appropriate credentials.](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html)
- [You must have terraform and its own prerequisites installed.](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

## Notes

1. The bucket that is created is a public bucket. By default, AWS does not assign any ACL to new buckets and recommends all buckets be private. As this is a static website, it is set to a public ACL.
2. The set-up for the bucket domain comes with a few caveats:
	* No SSL/HTTPS set-up is available for this method. I believe this is only available with CloudFront.
	* As with the second point, if you are using an alternative DNS hosting provider, [you will need to create a CNAME record which points the subdomain to the endpoint of the bucket](https://docs.aws.amazon.com/acm/latest/userguide/dns-validation.html).
3. There are five outputs currently available for `terraform output`:
	* bucket_domain: The domain being used by the bucket.
	* bucket_endpoint: The S3 endpoint for the bucket.
	* hosted_zone: The hosted zone for the site.