#!/usr/bin/env bash

# Exit on error
set -e

# === Configuration ===
STACK_NAME="NetBootVPC"
TEMPLATE_FILE="template.yaml"
REGION="us-east-1"

VPC_CIDR="10.200.123.0/24"
PUBLIC_SUBNET_CIDR="10.200.123.0/25"
PRIVATE_SUBNET_CIDR="10.200.123.128/25"
AVAILABILITY_ZONE="us-east-1a"

echo "Deploying CloudFormation stack: $STACK_NAME in $REGION"

# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/cloudformation/deploy/index.html
aws cloudformation deploy \
  --stack-name "$STACK_NAME" \
  --template-file "$TEMPLATE_FILE" \
  --region "$REGION" \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameter-overrides \
    VpcCidr=$VPC_CIDR \
    PublicSubnetCidr=$PUBLIC_SUBNET_CIDR \
    PrivateSubnetCidr=$PRIVATE_SUBNET_CIDR \
    AvailabilityZone=$AVAILABILITY_ZONE

echo "Waiting for stack creation to complete..."
aws cloudformation wait stack-create-complete \
  --stack-name "$STACK_NAME" \
  --region "$REGION"

echo "Stack $STACK_NAME deployed successfully."

# Print outputs
aws cloudformation describe-stacks \
  --stack-name "$STACK_NAME" \
  --region "$REGION" \
  --query "Stacks[0].Outputs" \
  --output table