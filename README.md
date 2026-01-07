# VPC Peering Connection Lab

AWS learning laboratory to create and configure a VPC Peering Connection using Terraform.

## Lab Objective

This lab teaches how to connect two VPCs privately to enable communication between resources in different networks using VPC Peering.

### Learning Objectives

- ✅ Create a VPC peering connection
- ✅ Configure route tables to use VPC peering
- ✅ Enable VPC Flow Logs for network traffic analysis
- ✅ Lab infrastructure fully deployed and configured

## Architecture

```
┌─────────────────────────────────┐      ┌─────────────────────────────────┐
│  Lab VPC (10.0.0.0/16)          │      │  Shared VPC (10.5.0.0/16)       │
│                                 │      │                                 │
│  ┌──────────────────────────┐   │      │  ┌──────────────────────────┐   │
│  │ Public Subnet            │   │      │  │ Private Subnet 1         │   │
│  │ (10.0.0.0/24)            │   │      │  │ (10.5.0.0/23)            │   │
│  │                          │   │      │  │                          │   │
│  │ ┌──────────────────────┐ │   │      │  │ ┌──────────────────────┐ │   │
│  │ │ Application Server   │ │   │◄────►│  │ │ MySQL RDS Instance   │ │   │
│  │ │ (EC2)                │ │   │      │  │ │                      │ │   │
│  │ └──────────────────────┘ │   │      │  │ └──────────────────────┘ │   │
│  └──────────────────────────┘   │      │  └──────────────────────────┘   │
│                                 │      │                                 │
│  ┌──────────────────────────┐   │      │  ┌──────────────────────────┐   │
│  │ Private Subnet           │   │      │  │ Private Subnet 2         │   │
│  │ (10.0.2.0/23)            │   │      │  │ (10.5.2.0/23)            │   │
│  └──────────────────────────┘   │      │  └──────────────────────────┘   │
└─────────────────────────────────┘      └─────────────────────────────────┘
              ▲                                        ▲
              │                                        │
              └────────── VPC Peering (Lab-Peer) ─────┘
                         pcx-03db9740774b09684

                         VPC Flow Logs enabled ✓
                         CloudWatch Log Group: ShareVPCFlowLogs
```

## Completed Tasks

### ✅ 1. Initial Terraform Configuration
- AWS provider configured for us-east-1
- Variables defined for VPC names and Flow Logs settings
- Outputs configured for all resources
- Data sources for existing AWS resources

### ✅ 2. VPC Peering Connection
- Created with ID: `pcx-03db9740774b09684`
- Status: `active`
- Connects Lab VPC (vpc-0649d687ca4c9a8d1) ↔ Shared VPC (vpc-0709654eca0f343f5)
- Auto-accept enabled (same account)

### ✅ 3. Route Tables Configuration
- Lab Public Route Table: Routes 10.5.0.0/16 traffic to peering connection
- Shared-VPC Route Table: Routes 10.0.0.0/16 traffic to peering connection
- Bidirectional routing fully functional
- Data sources configured to locate route tables by name tag

### ✅ 4. VPC Flow Logs
- Enabled for Shared VPC
- CloudWatch Log Group: `ShareVPCFlowLogs` (auto-created)
- Traffic type: ALL (captures both ACCEPT and REJECT)
- Aggregation interval: 60 seconds (1 minute)
- IAM Role: `vpc-flow-logs-Role` (pre-existing)
- Destination: CloudWatch Logs

## Project Structure

```
VPC-Peering-Connection/
├── provider.tf          # AWS provider configuration
├── variables.tf         # Input variables
├── main.tf              # Data sources and resources
├── outputs.tf           # Output values
├── terraform.tfstate    # Current state (auto-generated)
├── .terraform/          # Terraform plugins (auto-generated)
├── .terraform.lock.hcl  # Dependency lock file
├── CLAUDE.md            # Guide for Claude Code
└── README.md            # This file
```

## Terraform Commands

### Initialize project
```bash
terraform init
```

### Validate configuration
```bash
terraform validate
```

### View change plan
```bash
terraform plan
```

### Apply changes
```bash
terraform apply
```

### View outputs
```bash
terraform output
```

### View current state
```bash
terraform show
```

### Destroy resources (cleanup)
```bash
terraform destroy
```

## Resources Managed by Terraform

### Created Resources:
- **VPC Peering Connection**: `Lab-Peer` (pcx-03db9740774b09684)
- **Route (Lab → Shared)**: 10.5.0.0/16 → pcx-03db9740774b09684
- **Route (Shared → Lab)**: 10.0.0.0/16 → pcx-03db9740774b09684
- **VPC Flow Log**: Shared VPC flow log with CloudWatch integration

### Pre-existing Resources (referenced via data sources):
- Lab VPC: vpc-0649d687ca4c9a8d1 (10.0.0.0/16)
- Shared VPC: vpc-0709654eca0f343f5 (10.5.0.0/16)
- Lab Public Route Table
- Shared-VPC Route Table
- IAM Role: vpc-flow-logs-Role
- Application Server (EC2)
- MySQL RDS Instance

### Auto-created Resources (by AWS):
- CloudWatch Log Group: `ShareVPCFlowLogs`

## Key Learnings from This Lab

### AWS Concepts Covered:
1. **VPC Peering**: Network connection between two VPCs using private IP addresses
2. **Route Tables**: Configuring bidirectional routes for peering traffic
3. **VPC Flow Logs**: Capturing and monitoring network traffic
4. **CloudWatch Logs**: Centralized log management and analysis
5. **IAM Roles**: Service-to-service permissions for Flow Logs

### Terraform Concepts Applied:
1. **Data Sources**: Querying existing AWS resources
2. **Resources**: Creating and managing infrastructure
3. **Variables**: Parameterizing configurations
4. **Outputs**: Exposing resource information
5. **Dependencies**: Automatic resource ordering by Terraform

### Important Notes:
- **CIDR Blocks**: Non-overlapping IP ranges required for VPC peering
- **Bidirectional Routes**: Both VPCs need routes to enable communication
- **Flow Log Aggregation**: 60-second intervals for near real-time monitoring
- **IAM Permissions**: AWS Lab restrictions prevented tag creation on CloudWatch resources
- **Auto-creation**: CloudWatch Log Groups can be auto-created by VPC Flow Logs service

## Information

- **Region:** us-east-1
- **Code style:** Terraform in English, comments in Spanish
- **Educational objective:** Learn AWS and Terraform with step-by-step mentoring
- **Lab type:** AWS Academy/Hands-on Lab with pre-configured resources

## Next Steps (Beyond This Lab)

If you want to extend this lab, consider:
1. Testing connectivity between Application Server and MySQL instance
2. Analyzing VPC Flow Logs in CloudWatch
3. Adding VPC Flow Logs for Lab VPC as well
4. Implementing security group rules refinements
5. Setting up CloudWatch alarms for traffic patterns

---

**Last updated:** 2026-01-07
**Status:** ✅ Completed - All infrastructure deployed and configured successfully
