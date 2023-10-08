variable "domain_name" {
  type        = string
  description = "Name of the zone. Usually the name of the domain you're creating."
}

# Optional if you want multiple ACM certs for the same root domain and same zone.
# Once given, this would then need to be looped over to generate the cert resource
# and create the validation records.
variable "acm_alternative_domain_list" {
  type        = map(string)
  description = "Creates ACM certs based off of how many ACM"
  default = {}
}

variable "tag_list" {
  type        = map(any)
  description = "Pass in a set of tags to give the various resources."
  default = {}
}