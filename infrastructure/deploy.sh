#!/bin/bash -e

DIRNAME=$(dirname $0)

AWS_REGION="eu-west-1"
AWS_PROFILE="pat-parameters"

STACK_NAME="pat-management"

aws cloudformation list-stacks \
    --region $AWS_REGION --profile $AWS_PROFILE \
    | jq '.StackSummaries[] | select(.StackStatus != "DELETE_COMPLETE") | .StackName' \
    | grep pat-management
RC=$?


if [[ $RC == 0 ]]; then
    aws cloudformation update-stack \
        --profile $AWS_PROFILE \
        --region $AWS_REGION \
        --stack-name $STACK_NAME \
        --template-body "file://${DIRNAME}/cf-template.yaml" \
        --capabilities CAPABILITY_IAM
else
    aws cloudformation create-stack \
        --profile $AWS_PROFILE \
        --region $AWS_REGION \
        --stack-name $STACK_NAME \
        --template-body "file://${DIRNAME}/cf-template.yaml" \
        --capabilities CAPABILITY_IAM
fi
