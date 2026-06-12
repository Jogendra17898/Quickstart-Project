# Azure Landing Zone using Terraform

## Overview

This project demonstrates the creation of a basic Azure Landing Zone using Terraform.

The infrastructure includes:

* Resource Groups
* Storage Accounts
* Virtual Networks (VNets)
* Subnets
* Network Security Groups (NSGs)
* Network Interfaces (NICs)

The project is designed to help understand Infrastructure as Code (IaC) concepts and Azure networking fundamentals using Terraform.

---

## Architecture

```text
Resource Groups
├── Storage Accounts
├── Virtual Networks
│   ├── Subnets
│   └── Network Security Groups
└── Network Interfaces
```

---

## Prerequisites

* Azure Subscription
* Terraform
* Azure CLI

Verify installation:

```bash
terraform version
az version
```

Login to Azure:

```bash
az login
```

---

## Project Structure

```text
.
├── provider.tf
├── variables.tf
├── terraform.tfvars
├── main.tf
├── outputs.tf
└── README.md
```

---

## Deployment

Initialize Terraform:

```bash
terraform init
```

Validate configuration:

```bash
terraform validate
```

Review execution plan:

```bash
terraform plan
```

Deploy resources:

```bash
terraform apply --auto-approve
```

---

## Destroy Resources

To remove all deployed resources:

```bash
terraform destroy --auto-approve
```

---

## Technologies Used

* Terraform
* Microsoft Azure
* Azure CLI

---

## Learning Objectives

* Infrastructure as Code (IaC)
* Azure Resource Management
* Azure Networking
* Terraform Variables and Maps
* Terraform for_each
* Azure NSG and Subnet Configuration

---

## Author

Jogendra Singh
DevOps & Cloud Infrastructure Engineer
