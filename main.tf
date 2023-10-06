# Delegation set is used to give a dedicated set of name servers
# to the zone.

resource "aws_route53_delegation_set" "delset" {

  reference_name = var.domain_name
}

# Zone of the domain you're trying to connect to.
resource "aws_route53_zone" "zone" {

  name              = var.domain_name
  delegation_set_id = aws_route53_delegation_set.delset.id

  tags = var.tag_list
}

# Creates the ACM Certificate for the given domain.
resource "aws_acm_certificate" "domain_acm_certificate" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = var.tag_list
}

# These name servers are assigned when you create and/or import the domain from another
# registrar. This resource is adopted and won't be destroyed on `terraform destroy`.
# Probably a one-time thing. Also can be used for a module.

# Registered Domain has a dependency on the zone so the zone can be created first.
# Once the zone is created, it will update the registered domain with the correct
# name servers.

resource "aws_route53domains_registered_domain" "domain" {
  domain_name = var.domain_name

  dynamic "name_server" {
    for_each = aws_route53_delegation_set.delset.name_servers

    content {
      name = name_server.value
    }
  }
}

resource "aws_route53_record" "acm_validation" {
  for_each = {
    for dvo in aws_acm_certificate.domain_acm_certificate.domain_validation_options : dvo.domain_name => {
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
  zone_id         = aws_route53_zone.zone.zone_id
}

# Generate certificates if there's values inside of this var.
resource "aws_acm_certificate" "alternative_acm_certificates" {
  for_each = var.acm_alternative_domain_list

  domain_name       = each.value
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = var.tag_list
}

# Add to the validation via DNS.
resource "aws_route53_record" "alternative_acm_validation" {
  for_each = {
    for alternative_domains in aws_acm_certificate.alternative_acm_certificates : alternative_domains => {
      for dvo in alternative_domains.domain_validation_options : dvo.domain_name => {
        name   = dvo.resource_record_name
        record = dvo.resource_record_value
        type   = dvo.resource_record_type
      }
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.zone.zone_id
}