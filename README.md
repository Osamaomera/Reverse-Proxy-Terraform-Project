---

# Revese Proxy Congiquration with Terraform

## Description
This project utilizes Terraform to automate the configuration of an AWS cloud infrastructure. The infrastructure consists of a Virtual Private Cloud (VPC) with subnets distributed across two availability zones. Each subnet is configured with appropriate resources including EC2 instances, security groups, and Application Load Balancers (ALB) to manage traffic.It provisions and manages resources on AWS Cloud Provider, enabling the deployment of two Ec2 instance (Apache) with Private subnet and LoadBalancer for Private instances ,also we have Two Ec2 instance (Nginx) with Public subnet and LoadBalancer for Public instances act as Reverse proxy that's can enhance security by acting as an intermediary between clients and servers, shielding the backend infrastructure from direct exposure to the internet and providing an additional layer of defense against attacks.

## Architecture Diagram
![](ScreenShots/aws_terraform.drawio.svg)

## Table of Contents
- [Modules](#modules)
- [Infrastructure Overview](#infrastructure-overview)
- [Prerequisites](#prerequisites)
- [Getting Started](#Getting Started)
- [Contributing](#contributing)


## Modules
1. **VPC Module**: Configures the Virtual Private Cloud including CIDR block, subnets, route tables, and internet gateway.
2. **Subnets Module**: Creates public and private subnets within the VPC across multiple availability zones.
3. **EC2 Module**: Defines EC2 instances for both public and private subnets, including the provisioning of proxy servers and Apache servers.
4. **Load Balancer Module**: Sets up Application Load Balancers to distribute traffic between public subnets and route traffic from public subnets to private subnets.

## Infrastructure Overview
The infrastructure is structured as follows:

- **VPC**: A Virtual Private Cloud providing a logically isolated section of the AWS Cloud.
- **Subnets**:
  - Public Subnets: Hosts proxy servers and ALBs. These are accessible from the internet.
  - Private Subnets: Contains Apache servers, isolated from direct internet access.
- **EC2 Instances**:
  - Proxy Servers: Running on instances in public subnets to manage incoming and outgoing traffic.
  - Apache Servers: Hosted on instances in private subnets serving web content.
- **Security Groups**: Define inbound and outbound traffic rules for EC2 instances to control access.
- **Load Balancers**: Facilitate the distribution of incoming traffic across multiple instances and routing from public to private subnets.

## Prerequisites
Before using this Terraform configuration, ensure you have:
- An AWS account with appropriate permissions.
- Installed Terraform locally. See [Terraform Installation Guide](https://learn.hashicorp.com/tutorials/terraform/install-cli) for instructions.

## Getting Started
1. Clone this repository to your local machine.
  ```
    git clone https://github.com/Osamaomera/Reverse-Proxy-Terraform-Project.git
  ```
2. Navigate to the project directory.
  ```
  cd Reverse-Proxy-Terraform-Project
  ```
3. Run `terraform init` to initialize the working directory.
4. Run `terraform plan` to review the planned changes.
5. Run `terraform apply` to apply the Terraform configuration and create the infrastructure.
6. After successful provisioning, access AWS Management Console to view the deployed resources.

## Contributing
Contributions are welcome! If you find any issues or have suggestions for improvements, please submit a pull request or open an issue on GitHub.
