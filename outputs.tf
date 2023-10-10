output "root_domain_zone_id" {
  description = "Root domain zone id."
  value       = aws_route53_zone.zone.zone_id
}

output "root_domain_deligation_set" {
  description = "Dedicated set of name servers if you want to reuse them."
  value       = aws_route53_delegation_set.delset
}

output "root_domain_certificate" {
  description = "Created domain certificate for the root."
  value       = module.domain_acm
}

output "alternative_domain_certificates" {
  description = "An array of objects that houses any alternative domains."
  value       = module.alternative_acm
}