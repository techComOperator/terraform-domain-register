module "domain-register" {
  source  = "../../.."

# If you're running the tests manually, please use your own domain that you own
# in AWS. Also, no tags are involved.
  domain_name = "example.com"
}