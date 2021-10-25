# Kubevela Helm Chart

## Introduction

The Kubevela 

## Helm Chart

### Instructions to use Helm Charts

    helm repo add kubevela https://charts.kubevela.net/core

Additional details about the official KubeVela helm chart can be found [here](https://github.com/oam-dev/kubevela)

#### Instructions to upload kubevela Docker image to AWS ECR

## Docker Image

Step1: Download the docker image to your local Mac/Laptop

        $ docker pull oamdev/vela-core:v1.1.6

Step2: Retrieve an authentication token and authenticate your Docker client to your registry. Use the AWS CLI:

        $ aws ecr get-login-password --region eu-south-1 | docker login --username AWS --password-stdin <account id>.dkr.ecr.eu-south-1.amazonaws.com

Step3: Create an ECR repo for vela-core if you don't have one

         $ aws ecr create-repository --repository-name  oamdev/vela-core --image-scanning-configuration scanOnPush=true

Step4: After the build completes, tag your image so, you can push the image to this repository:

        $ docker tag oamdev/vela-core:v1.1.6 <account id>.dkr.ecr.eu-south-1.amazonaws.com/oamdev/vela-core:v1.1.6

Step5: Run the following command to push this image to your newly created AWS repository:

        $ docker push <accountid>.dkr.ecr.eu-south-1.amazonaws.com/oamdev/vela-core:v1.1.6
