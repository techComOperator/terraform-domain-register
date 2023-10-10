package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/logger"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestExamplesRootOnly(t *testing.T) {
	logger.Default.Logf(t, "Starting Test - Domains")

	terraformOptions := &terraform.Options{
		TerraformDir: "./examples/domains",
	}

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)
}

func TestExamplesSubDomains(t *testing.T) {
	logger.Default.Logf(t, "Starting Test - Subdomains")

	terraformOptions := &terraform.Options{
		TerraformDir: "./examples/subdomains",
	}

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)
}
