#!/bin/sh

STACK_NAME=$1

REGION=`aws configure get region`

aws cloudformation delete-stack --region ${REGION} --stack-name ${STACK_NAME}
