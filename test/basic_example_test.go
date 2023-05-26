package test

import (
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/service/ecs"
	"os"
	"testing"

	TTAWS "github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/terraform"

	"github.com/stretchr/testify/assert"

	"github.com/aws/aws-sdk-go/aws/session"
)

func TestTerraformBasicExample(t *testing.T) {
	clusterName := "terraform-test-cluster-" + GetShortId()

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../examples/basic-example",
		Vars: map[string]interface{}{
			"name": clusterName,
		},
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	name := terraform.Output(t, terraformOptions, "name")
	assert.NotEmpty(t, name)

	arn := terraform.Output(t, terraformOptions, "arn")
	assert.NotEmpty(t, arn)

	sess, err := NewSession(os.Getenv("AWS_REGION"))
	assert.NoError(t, err)

	client := ecs.New(sess)

	input := &ecs.DescribeClustersInput{Clusters: []*string{&clusterName}}
	output, err := client.DescribeClusters(input)
	assert.NoError(t, err)

	assert.Equal(t, 1, len(output.Clusters))

	assert.Equal(t, clusterName, aws.StringValue(output.Clusters[0].ClusterName))
}

func NewSession(region string) (*session.Session, error) {
	sess, err := TTAWS.NewAuthenticatedSession(region)
	if err != nil {
		return nil, err
	}

	return sess, nil
}

func GetShortId() string {
	githubSha := os.Getenv("GITHUB_SHA")
	if len(githubSha) >= 7 {
		return githubSha[0:6]
	}

	return "local"
}
