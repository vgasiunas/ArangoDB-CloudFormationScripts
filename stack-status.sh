#!/bin/sh

STACK_NAME=$1

REGION=`aws configure get region`

aws cloudformation list-stacks --region ${REGION} \
  | jq "[.StackSummaries[] | select(.StackName == \"${STACK_NAME}\")][0] | .StackStatus"
