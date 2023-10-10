# terraform-domain-register
Module that allows you to register a domain and have that domain be associated with an ACM.

```
module "domain-register" {
  source = "git@github.com:techcomoperator/terraform-domain-register.git"
}
```

# Usage
```
module "domain_register" {
  source = "git@github.com:techcomoperator/terraform-domain-register.git"
  domain_name = "example.com"
  tag_list = {
    key = "value that's a string"
  }
  fqdn_subdomain_list = ["one.example.com", "two.example.com"]
}
```