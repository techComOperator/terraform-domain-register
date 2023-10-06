output "root_domain_zone_id" {
    description = "Root domain zone id."
    value = aws_route53_zone.zone.zone_id
}

output "root_domain_deligation_set" {
    description = "Dedicated set of name servers if you want to reuse them."
    value = aws_route53_delegation_set.delset
}

