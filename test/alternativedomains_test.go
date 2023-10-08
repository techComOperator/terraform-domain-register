package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/logger"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestExamplesAlternativeDomains(t *testing.T) {
	logger.Default.Logf(t, "Starting Test - Added Extra Domains for ACM Creation.")

	terraformOptions := &terraform.Options{
		TerraformDir: "./examples/alternative_domains",
	}

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)
}
