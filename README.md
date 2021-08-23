# Scripts for managing AWS Cloud Formation deployments

## Purpose

The project includes a cloud formation template for creating VMs prepared for deploying an ArangoDB cluster. 
Note that the scripts do not install ArangoDB on the created VMs. 

## Prerequisites

Install and configure AWS client as described in:
https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html

Create a key-pair in the region you want to deploy the cluster:
https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html

Make sure you have necessary AWS permissions for creating and managing CloudFormation stacks

## Deploy a CloudFormation Stack

```
./set-region eu-central-1

./deploy.sh Vaidas 3 t3.medium 100 vaidas-eu-central-1

./stack-status.sh Vaidas
```

## Installing ArangoDB

List the public DNS names of the created VMs:

```
./list-public-dns.sh Vaidas
```

Connect to the created VMs the using SSH key and perform the installation following the instructions for CentOS:
https://www.arangodb.com/download-arangodb-enterprise/

On the first machine (here ec2-XXX-XXX-XXX-XXX.eu-central-1.compute.amazonaws.com)

```
screen
arangodb
Ctrl+A d
```

On other machines

```
screen
arangodb --starter.join ec2-XXX-XXX-XXX-XXX.eu-central-1.compute.amazonaws.com
Ctrl+A d
```

## Delete a Stack

```
./list-stacks.sh

./delete-stack Vaidas
```
