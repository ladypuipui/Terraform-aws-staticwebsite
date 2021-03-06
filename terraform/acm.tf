provider "aws" {
  alias  = "virginia"
  region = "us-east-1"
  profile = "defaultprofile"
}

data "aws_route53_zone" "domain" {
  name         = "${var.root_domain}"
  private_zone = false
}

resource "aws_acm_certificate" "cert" {
  provider                  = "aws.virginia"
  domain_name               = "${var.site_domain}"
  validation_method         = "DNS"
}

resource "aws_route53_record" "cert_validation" {
  provider                  = "aws.virginia"
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.domain.zone_id
}

resource "aws_acm_certificate_validation" "cert" {
  provider                = "aws.virginia"
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}