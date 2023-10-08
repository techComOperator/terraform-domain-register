package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/logger"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestExamplesRootOnly(t *testing.T) {
	logger.Default.Logf(t, "Starting Test - Root Domain Only")

	terraformOptions := &terraform.Options{
		TerraformDir: "./examples/root_only",
	}

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)
}
