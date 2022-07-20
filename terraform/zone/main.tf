locals {
  domain_name = "test.dimash.cloudns.nz"
}

resource "aws_route53_zone" "primary" {
  name = local.domain_name
}

resource "aws_acm_certificate" "my_domain" {
  domain_name               = local.domain_name
  validation_method         = "DNS"

  tags = {
    Environment = "test"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "my_domain" {
  for_each = {
  for dvo in aws_acm_certificate.my_domain.domain_validation_options : dvo.domain_name => {
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
  zone_id         = "${aws_route53_zone.primary.zone_id}"
}

resource "aws_acm_certificate_validation" "my_domain" {
  certificate_arn         = aws_acm_certificate.my_domain.arn
  validation_record_fqdns = [for record in aws_route53_record.my_domain : record.fqdn]
}