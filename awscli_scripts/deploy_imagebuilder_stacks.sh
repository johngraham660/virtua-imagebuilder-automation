#!/bin/bash

# =================================================
# Deploy the EC2ImageBuilder Cloudformationn Stacks
# =================================================

STACKFILES="centos7-cloudwatch-buildcomponent-stack \
            centos7-update-buildcomponent-stack \
            rhel7_update_buildcomponent_stack \
            rhel7-cloudwatch-buildcomponent-stack"

for stack in ${STACKFILES}
do
  aws cloudformation create-stack --stack-name ${stack} --template-url https://virtua-cloudformation-templates.s3-eu-west-1.amazonaws.com/${stack}.yaml
done