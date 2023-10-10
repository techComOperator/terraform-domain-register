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

# Generate the ACM and validation records for the Domain.
module "domain_acm" {
  source = "./modules/acm_cert_with_validation"

  domain_name = var.domain_name
  tag_list = var.tag_list
  zone_id = aws_route53_zone.zone.zone_id
}

# If any other domains need to be validated with certs, generate those.
module "alternative_acm" {
  source = "./modules/acm_cert_with_validation"

  for_each = var.acm_alternative_domain_list

  domain_name = each.value
  tag_list = var.tag_list
  zone_id = aws_route53_zone.zone.zone_id
}