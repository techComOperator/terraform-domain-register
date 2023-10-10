variable "domain_name" {
  type        = string
  description = "Name of the zone. Usually the name of the domain you're creating."
}

variable "fqdn_subdomain_list" {
  type        = set(string)
  description = "Creates certificates and validation records for the given subdomains. (Optional)"
  default     = []
}

variable "tag_list" {
  type        = map(any)
  description = "Pass in a set of tags to give the various resources. (Optional)"
  default     = {}
}