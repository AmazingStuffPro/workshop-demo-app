#!/bin/bash

# Downloading terraform 
TF="terraform.zip"
wget -O ${TF} https://releases.hashicorp.com/terraform/0.11.8/terraform_0.11.8_linux_amd64.zip 
unzip ${TF} 
aws s3 cp s3://jenkins-rise-demo/workshop-key2.pem ~/.ssh/workshop-key2.pem

# Initializing terraform working directory and provisioning instance
./terraform init
./terraform apply -var "git_repo=${GIT_URL}" \
                -var "git_branch=${GIT_BRANCH}" \
                -var "ec2_tag=${GIT_BRANCH}" \
                --auto-approve 
