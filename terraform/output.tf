# ---------------
# output.tf
# ---------------

output "cloud_front_destribution_domain_name" {
  value = "${aws_cloudfront_distribution.site.domain_name}"
}

