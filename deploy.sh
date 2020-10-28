#!/bin/sh

STACK_NAME=$1
NUMBER_OF_INSTANCES=$2
INSTANCE_TYPE=$3
VOLUME_SIZE=$4
KEY_NAME=$5

TEMPLATE_BODY="file://AWS-CF-template.json"
REGION=`aws configure get region`

IMAGE=$(aws ec2 describe-images \
    --owners amazon \
    --filters 'Name=name,Values=amzn2-ami-hvm-2.0.????????.?-x86_64-gp2' 'Name=state,Values=available' \
    --query 'reverse(sort_by(Images, &CreationDate))[:1].ImageId' \
    --output text --region=${REGION})

echo Deploying $REGION $IMAGE $INSTANCE_TYPE $KEY_NAME

aws cloudformation create-stack \
 --capabilities CAPABILITY_IAM \
 --template-body ${TEMPLATE_BODY} \
 --stack-name ${STACK_NAME} \
 --region ${REGION} \
 --parameters \
 ParameterKey=InstanceType,ParameterValue=${INSTANCE_TYPE} \
 ParameterKey=NumberOfInstances,ParameterValue=${NUMBER_OF_INSTANCES} \
 ParameterKey=KeyName,ParameterValue=${KEY_NAME} \
 ParameterKey=Image,ParameterValue=${IMAGE} \
 ParameterKey=VolumeSize,ParameterValue=${VOLUME_SIZE}
