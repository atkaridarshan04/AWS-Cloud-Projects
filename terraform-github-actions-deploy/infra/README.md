# Infrastructure Module

## 🏗️ Architecture Overview

This module creates a complete containerized application infrastructure on AWS with secure networking and IAM permissions.

```
┌─────────────────────────────────────────────────────────┐
│                    AWS VPC (10.0.0.0/16)                │
│                                                         │
│  ┌─────────────────────────────────────────────────┐    │
│  │         Public Subnet (10.0.1.0/24)             │    │
│  │                                                 │    │
│  │  ┌─────────────────┐    ┌─────────────────┐     │    │
│  │  │   EC2 Instance  │    │  Security Group │     │    │
│  │  │   - Docker      │◄───┤  - SSH (22)     │     │    │
│  │  │   - IAM Role    │    │  - HTTP (80)    │     │    │
│  │  │   - Public IP   │    │  - All Egress   │     │    │
│  │  └─────────────────┘    └─────────────────┘     │    │
│  │           │                                     │    │
│  │           ▼                                     │    │
│  │  ┌─────────────────┐                            │    │
│  │  │ Internet Gateway│◄──Route Table              │    │
│  │  └─────────────────┘                            │    │
│  └─────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────┘
                           │
                           ▼
              ┌─────────────────────────┐
              │    ECR Repository       │
              │  - Container Images     │
              │  - Mutable Tags         │
              └─────────────────────────┘
```

## 🔧 Core Components

### Networking Layer
- **VPC**: Isolated network environment with DNS resolution
- **Public Subnet**: Single AZ deployment for simplicity
- **Internet Gateway**: Direct internet access for the instance
- **Route Table**: Routes all traffic (0.0.0.0/0) to IGW

### Compute Layer
- **EC2 Instance**: t3.micro Ubuntu with Docker pre-installed
- **User Data**: Automated setup of Docker, AWS CLI v2
- **Public IP**: Direct internet accessibility

### Security Layer
- **Security Group**: Stateful firewall rules
  - Inbound: SSH (22), HTTP (80)
  - Outbound: All traffic allowed
- **IAM Role**: Least privilege access for ECR operations
- **Instance Profile**: Attaches IAM role to EC2

### Container Registry
- **ECR Repository**: Private Docker image storage
- **Mutable Tags**: Allows image updates with same tag

## 🔐 IAM Permissions Model

```
EC2 Instance
     │
     ▼
IAM Instance Profile ──► IAM Role
     │                      │
     ▼                      ▼
ECR Permissions:       SSM Permissions:
- GetAuthorizationToken  - Session Manager
- BatchCheckLayerAvail   - Systems Manager
- GetDownloadUrlForLayer
- BatchGetImage
- DescribeImages
```

## 📋 Resource Configuration

| Resource | Configuration | Purpose |
|----------|---------------|---------|
| **VPC** | 10.0.0.0/16, DNS enabled | Network isolation |
| **Subnet** | 10.0.1.0/24, eu-north-1a | Single AZ deployment |
| **EC2** | t3.micro, Ubuntu AMI | Cost-effective compute |
| **Security Group** | Ports 22,80 inbound | Web + SSH access |
| **ECR** | Mutable tags | Container image storage |

## 📤 Outputs

- `ec2_public_ip` - Instance public IP for SSH/HTTP access
- `ec2_public_dns` - Instance DNS name
- `ecr_repository_url` - Full ECR repository URL for Docker push/pull
- `vpc_id` - VPC identifier for reference
- `ec2_iam_role_name` - IAM role name for additional policy attachments