#!/bin/bash

# =================================================
# Deploy the EC2ImageBuilder Cloudformationn Stacks
# =================================================


function deleteStack() {
  # ============================
  # Delete buildcomponent stacks
  # ============================
  for STACK in ${STACKFILES}
  do
    echo "Deleting Stack: ${STACK}"
    aws cloudformation delete-stack --stack-name ${STACK}
    sleep 5
  done

}

function createStack() {
  # ============================
  # Create buildcomponent stacks
  # ============================
  for STACK in ${STACKFILES}
  do
    echo "Creating Stack: ${STACK}"
    aws cloudformation create-stack --stack-name ${STACK} --template-url https://${BUCKET}.s3-${REGION}.amazonaws.com/${STACK}.yaml
  done

}

function usage() {
  echo "Usage:"
  echo "  --create, -c : create stack"
  echo "  --delete, -d : delete stack"
  echo "  --help,   -h : Show this usage message"
}

# ====
# Main
# ====

# =======================================
# Check the user supplied a vailid input.
# =======================================
main() {

  REGION="eu-west-1"
  BUCKET="virtua-cloudformation-templates"

  if [[ -z ~/.aws/credentials ]]
  then
    echo "Cannot find credentials file to connect to AWS"
    exit 1
  else
    # We found credentials but no idea if they work
    STACKFILES=$(aws s3 ls s3://${BUCKET} | grep buildcomponent-stack.yaml | awk '{print $NF}')
    echo "DEBUG: ${STACKFILES}"
    echo "DEBUG: ${BUCKET}"

    if [ -z ${STACKFILES} ]
    then
      # STACK files is empty, either way lets exit as we have no templates
      echo "Cannot identify the CloudFormation template names"
      exit 1
    fi
  fi

  if [[ $# -eq 0 ]]
  then
    usage
    exit 1
  fi  
  while test $# -gt 0
  do
    case "$1" in
      --create)
        createStack
        ;;
      --delete)
        deleteStack
        ;;
      --help)
        usage
        ;;
      -c)
        createStack
        ;;
      -d)
        deleteStack
        ;;
      -h)
        usage
        ;;
      *)
        echo "Option $1 is not recognised"
        exit 1
        ;;
    esac
    shift
  done
}

main "$@"