# VPC Peering Connection Lab

AWS learning laboratory to create and configure a VPC Peering Connection using Terraform.

## Lab Objective

This lab teaches how to connect two VPCs privately to enable communication between resources in different networks using VPC Peering.

### Learning Objectives

- ✅ Create a VPC peering connection
- ✅ Configure route tables to use VPC peering (in Terraform)
- ⏳ Apply changes to AWS infrastructure
- ⏳ Enable VPC Flow Logs for network traffic analysis
- ⏳ Test the peering connection
- ⏳ Analyze VPC flow logs

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
```

## Current Progress

### ✅ Completed

1. **Initial Terraform Configuration**
   - AWS provider configured
   - Variables defined
   - Outputs configured

2. **VPC Peering Connection**
   - Created with ID: `pcx-03db9740774b09684`
   - Status: `active`
   - Connects Lab VPC ↔ Shared VPC

3. **Route Tables Configuration (Terraform)**
   - Data sources added to locate route tables by name
   - Route resources created:
     - Lab VPC → Shared VPC: `10.5.0.0/16` via peering
     - Shared VPC → Lab VPC: `10.0.0.0/16` via peering
   - Outputs added for route verification

### 🚧 Next Step: Apply Terraform Changes

The VPC Peering is created and routes are configured in Terraform, but **not yet applied to AWS**.

**What to do:**
```bash
terraform validate  # Validate configuration syntax
terraform plan      # Preview changes (should show 2 routes to add)
terraform apply     # Apply changes to AWS
```

### ⏳ Pending

- Enable VPC Flow Logs
- Test connectivity between Application Server and MySQL
- Analyze Flow Logs

## Project Structure

```
VPC-Peering-Connection/
├── provider.tf          # AWS provider configuration
├── variables.tf         # Input variables
├── main.tf              # Data sources and resources
├── outputs.tf           # Output values
├── terraform.tfstate    # Current state (auto-generated)
├── .terraform/          # Terraform plugins (auto-generated)
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

### Destroy resources
```bash
terraform destroy
```

## Resources Managed by Terraform

- VPC Peering Connection: `Lab-Peer` (pcx-03db9740774b09684)
- Route in Lab VPC Public Route Table: 10.5.0.0/16 → pcx-03db9740774b09684
- Route in Shared VPC Route Table: 10.0.0.0/16 → pcx-03db9740774b09684

## Pre-existing Resources (queried via data sources)

- Lab VPC: vpc-0649d687ca4c9a8d1 (10.0.0.0/16)
- Shared VPC: vpc-0709654eca0f343f5 (10.5.0.0/16)
- Lab Public Route Table
- Shared-VPC Route Table
- Application Server (EC2)
- MySQL RDS Instance

## Important Information

- **Region:** us-east-1
- **Code style:** Terraform in English, comments in Spanish
- **Educational objective:** Learn AWS and Terraform with step-by-step mentoring

## Next Steps

1. ✅ ~~Configure route tables with `aws_route` resources~~ (Done in Terraform)
2. 🚧 Apply Terraform changes (`terraform apply`)
3. ⏳ Enable VPC Flow Logs with IAM roles and CloudWatch Log Groups
4. ⏳ Test connectivity Application Server → MySQL
5. ⏳ Analyze logs in CloudWatch

---

**Last updated:** 2026-01-07
**Status:** Route tables configured in Terraform, pending apply
