provider "aws" {
  alias  = "virginia"
  region = "us-east-1"
  profile = "defaultprofile"
}

data aws_route53_zone route53-zone {
  name         = "${root_domain}"
  private_zone = false
}

resource aws_acm_certificate cert {
  provider          = "aws.virginia"
  domain_name       = "${var.site_domain}"
  validation_method = "DNS"
}

resource aws_route53_record cert_validation {
  zone_id = data.aws_route53_zone.route53-zone.zone_id
  name    = aws_acm_certificate.cert.domain_validation_options[0].resource_record_name
  type    = aws_acm_certificate.cert.domain_validation_options[0].resource_record_type
  records = [aws_acm_certificate.cert.domain_validation_options[0].resource_record_value]
  ttl     = 60
}

resource aws_acm_certificate_validation cert {
  certificate_arn = aws_acm_certificate.cert.arn
  validation_record_fqdns = [aws_route53_record.cert_validation.fqdn]
}

