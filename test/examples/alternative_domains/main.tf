module "domain-register" {
  source  = "../../.."

# If you're running the tests manually, please use your own domain that you own
# in AWS.
  domain_name = "example.com"
  tag_list = ["a tag"]
  acm_alternative_domain_list = ["this.example.com", "another.example.com"]
}