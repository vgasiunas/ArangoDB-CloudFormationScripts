#!/bin/sh

REGION=`aws configure get region`

aws cloudformation list-stacks --region ${REGION} \
  | jq ".StackSummaries[] | { StackName, StackStatus }"
