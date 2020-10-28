#!/bin/sh

STACK_NAME=$1

REGION=`aws configure get region`

aws ec2 describe-instances --region ${REGION} \
   --filters "Name=tag:aws:cloudformation:stack-name,Values=${STACK_NAME}" \
 | jq --raw-output ".Reservations[].Instances[].PublicDnsName"
