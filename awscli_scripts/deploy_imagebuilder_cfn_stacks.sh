#!/bin/bash

# =================================================
# Deploy the EC2ImageBuilder Cloudformationn Stacks
# =================================================
REGION="eu-west-1"
BUCKET="virtua-cloudformation-templates"
STACKFILES="centos7-cloudwatch-buildcomponent-stack \
            centos7-update-buildcomponent-stack \
            rhel7-update-buildcomponent-stack \
            rhel7-cloudwatch-buildcomponent-stack"

# ============================
# Delete buildcomponent stacks
# ============================
for STACK in ${STACKFILES}
do
  echo "Deleting Stack: ${STACK}"
  aws cloudformation delete-stack --stack-name ${STACK}
  sleep 5
done

# ============================
# Create buildcomponent stacks
# ============================
for STACK in ${STACKFILES}
do
  echo "Creating Stack: ${STACK}"
  aws cloudformation create-stack --stack-name ${STACK} --template-url https://${BUCKET}.s3-${REGION}.amazonaws.com/${STACK}.yaml
done