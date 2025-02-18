
#---------------------------------------------------------#
# EKS CLUSTER CORE VARIABLES
#---------------------------------------------------------#
#Following fields used in tagging resources and building the name of the cluster
#e.g., eks cluster name will be {tenant}-{environment}-{zone}-{resource}
#---------------------------------------------------------#
org               = "aws"     # Organization Name. Used to tag resources
tenant            = "kubevela"  # AWS account name or unique id for tenant
environment       = "dev" # Environment area eg., preprod or prod
zone              = "dev"     # Environment with in one sub_tenant or business unit
terraform_version = "Terraform v1.0.1"
#---------------------------------------------------------#
# VPC and PRIVATE SUBNET DETAILS for EKS Cluster
#---------------------------------------------------------#
#This provides two options Option1 and Option2. You should choose either of one to provide VPC details to the EKS cluster
#Option1: Creates a new VPC, private Subnets and VPC Endpoints by taking the inputs of vpc_cidr_block and private_subnets_cidr. VPC Endpoints are S3, SSM , EC2, ECR API, ECR DKR, KMS, CloudWatch Logs, STS, Elastic Load Balancing, Autoscaling
#Option2: Provide an existing vpc_id and private_subnet_ids

#---------------------------------------------------------#
# OPTION 1
#---------------------------------------------------------#
create_vpc             = true
vpc_cidr_block         = "10.1.0.0/18"
private_subnets_cidr   = ["10.1.0.0/22", "10.1.4.0/22", "10.1.8.0/22"]
enable_private_subnets = true
enable_public_subnets  = true
public_subnets_cidr    = ["10.1.12.0/22", "10.1.16.0/22", "10.1.20.0/22"]


# Enable or Disable NAT Gateqay and Internet Gateway for Public Subnets
enable_nat_gateway = true
single_nat_gateway = true
create_igw         = true


# Change this to true when you want to create VPC endpoints for Private subnets
create_vpc_endpoints = false
#---------------------------------------------------------#
# OPTION 2
#---------------------------------------------------------#
//create_vpc = false
//vpc_id = "xxxxxx"
//private_subnet_ids = ['xxxxxx','xxxxxx','xxxxxx']

#---------------------------------------------------------#
# EKS CONTROL PLANE VARIABLES
# API server endpoint access options
#   Endpoint public access: true    - Your cluster API server is accessible from the internet. You can, optionally, limit the CIDR blocks that can access the public endpoint.
#   Endpoint private access: true   - Kubernetes API requests within your cluster's VPC (such as node to control plane communication) use the private VPC endpoint.
#---------------------------------------------------------#
kubernetes_version      = "1.27"
endpoint_private_access = true
endpoint_public_access  = true

# Enable IAM Roles for Service Accounts (IRSA) on the EKS cluster
enable_irsa = true

enabled_cluster_log_types    = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
cluster_log_retention_period = 1

enable_vpc_cni_addon  = true
vpc_cni_addon_version = "v1.15.0-eksbuild.2"

enable_coredns_addon  = true
coredns_addon_version = "v1.10.1-eksbuild.4"

enable_kube_proxy_addon  = true
kube_proxy_addon_version = "v1.27.4-minimal-eksbuild.2"


#---------------------------------------------------------#
# WORKER NODE GROUPS SECTION
# Define the following parameters to create EKS Node groups. If you need to two Node groups then you may need to duplicate the with different instance type
# NOTE: Also ensure Node groups config that you defined below needs to exist in this file <aws-eks-accelerator-for-terraform/source/main.tf>.
#         Comment out the node groups in <aws-eks-accelerator-for-terraform/source/main.tf> file if you are not defining below.
#         This is a limitation at this moment that the change needs ot be done in two places. This will be improved later
#---------------------------------------------------------#
#---------------------------------------------------------#
# MANAGED WORKER NODE INPUT VARIABLES FOR ON DEMAND INSTANCES - Worker Group1
#---------------------------------------------------------#
on_demand_node_group_name = "mg-m5-on-demand"
on_demand_ami_type        = "AL2_x86_64"
on_demand_disk_size       = 30
on_demand_instance_type   = ["t3.large"]
on_demand_desired_size    = 2
on_demand_max_size        = 2
on_demand_min_size        = 2

#---------------------------------------------------------#
# ENABLE HELM MODULES
# Please note that you may need to download the docker images for each
#          helm module and push it to ECR if you create fully private EKS Clusters with no access to internet to fetch docker images.
#          README with instructions available in each HELM module under helm/
#---------------------------------------------------------#
# Enable this if worker Node groups has access to internet to download the docker images
# Or Make it false and set the private contianer image repo url in source/main.tf; currently this defaults to ECR
public_docker_repo = true

#---------------------------------------------------------#
# DISABLE METRICS SERVER
#---------------------------------------------------------#
metrics_server_enable            = false
metric_server_image_tag          = "v0.4.2"
metric_server_helm_chart_version = "2.12.1"

#---------------------------------------------------------#
# ENABLE CLUSTER AUTOSCALER
#---------------------------------------------------------#
cluster_autoscaler_enable       = true
cluster_autoscaler_image_tag    = "v1.28.0"
cluster_autoscaler_helm_version = "9.29.3"

#---------------------------------------------------------#
# ENABLE KUBEVELA
#---------------------------------------------------------#
kubevela_enable       = true
kubevela_image_tag    = "v1.9.6"
kubevela_helm_chart_version = "1.9.6"

//---------------------------------------------------------//
// DISABLE ALB INGRESS CONTROLLER
//---------------------------------------------------------//
lb_ingress_controller_enable = false
aws_lb_image_tag             = "v2.2.1"
aws_lb_helm_chart_version    = "1.2.3"

#---------------------------------------------------------//
# DISABLE PROMETHEUS
#---------------------------------------------------------//
# Creates the AMP workspace and all the relevent IAM Roles
aws_managed_prometheus_enable = false

# Deploys Pometheus server with remote write to AWS AMP Workspace
prometheus_enable             = false
prometheus_helm_chart_version = "14.3.1"
prometheus_image_tag          = "v2.26.0"
alert_manager_image_tag       = "v0.21.0"
configmap_reload_image_tag    = "v0.5.0"
node_exporter_image_tag       = "v1.1.2"
pushgateway_image_tag         = "v1.3.1"
