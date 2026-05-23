# Quickstart-Project

## Overview

This project deploys a distributed inference system across multiple virtual machines using Terraform and cloud-init automation.

The system consists of a multi-tier architecture where inference requests are routed through an API layer, then forwarded through a TypeScript worker to a Python-based inference worker hosting the language model.

The infrastructure is designed with security, scalability, and reproducibility in mind.

## Architecture

### Components

| Component | Purpose |
|------------|----------|
| API VM | Public entry point for inference requests |
| TypeScript Worker VM | Handles RPC requests and forwards them to inference worker |
| Python Worker VM | Loads and executes the language model |
| Private Subnet | Internal communication between workers |
| VPC | Isolated network environment |

### Network Topology

```text
                          Internet
                              |
                              |
                     +----------------+
                     |     API VM     |
                     |   Public IP    |
                     +----------------+
                              |
                              |
                     Private Subnet RPC
                              |
          +----------------------------------------+
          |                                        |
          |                                        |
+----------------------+              +----------------------+
|  TypeScript Worker   | ------------>|   Python Worker     |
|   caller-worker      |     RPC      | inference-worker    |
+----------------------+              +----------------------+

```

### Request Flow

```text
Client
  |
  v
API Endpoint
  |
  v
caller-worker (TypeScript)
  |
  v
inference-worker (Python)
  |
  v
Language Model
  |
  v
Response
```

---

# Infrastructure

The infrastructure is provisioned entirely using Terraform.

Resources created:

- Resource Group / VPC
- Virtual Network
- Private Subnet
- Network Security Rules
- API VM
- TypeScript Worker VM
- Python Worker VM
- Public IP (API VM only)

---

# Security Design

## Public Access

Only the API VM is exposed to the internet.

Allowed inbound ports:

| Port | Purpose |
|--------|---------|
| 22 | SSH |
| 80 | HTTP |
| 443 | HTTPS |
| 8080 | API Endpoint |

## Private Workers

The following machines do not have public IPs:

- TypeScript Worker VM
- Python Worker VM

Worker communication occurs exclusively through the private subnet.

RPC traffic never traverses the public internet.

---

# Deployment Instructions

## Prerequisites

Install:

- Terraform >= 1.5
- AWS CLI or GCloud CLI
- Git
- SSH Client

Verify installation:

```bash
terraform version
aws --version
git --version
```

---

# Clone Repository

```bash
git clone https://github.com/<username>/distributed-inference.git

cd distributed-inference
```

---

# Initialize Terraform

```bash
cd terraform

terraform init
```

---

# Validate Configuration

```bash
terraform validate
```

---

# Review Deployment Plan

```bash
terraform plan
```

---

# Deploy Infrastructure

```bash
terraform apply
```

Terraform will output:

```text
api_public_ip = xx.xx.xx.xx
```

Save this IP for testing.

---

# Worker Deployment

Worker installation is automated through cloud-init scripts.

Scripts:

```text
cloud-init/
├── api.sh
├── engine.sh
├── python-worker.sh
└── ts-worker.sh
```

During VM provisioning:

1. Dependencies are installed.
2. Project source is downloaded.
3. Worker services are configured.
4. Services are started automatically.

---

# Service Verification

SSH into API VM:

```bash
ssh ubuntu@<api_public_ip>
```

Verify services:

```bash
systemctl status api

systemctl status engine

systemctl status ts-worker

systemctl status python-worker
```

---

# API Usage

## Endpoint

```text
POST /v1/chat/completions
```

Example:

```bash
curl -X POST http://<api_public_ip>:8080/v1/chat/completions \
-H "Content-Type: application/json" \
-d '{
  "messages": [
    {
      "role": "user",
      "content": "What is DevOps?"
    }
  ]
}'
```

Sample Response:

```json
{
  "response": "DevOps is a combination of development and operations practices..."
}
```

---

# Infrastructure Lifecycle

## Destroy Environment

```bash
terraform destroy
```

This removes:

- VMs
- Networking
- Firewall Rules
- Public IPs

---

# Troubleshooting

## Verify VM Reachability

```bash
ping <api_public_ip>
```

---

## Check Open Ports

```bash
ss -tulpn
```

---

## Check Logs

```bash
journalctl -u api -f

journalctl -u ts-worker -f

journalctl -u python-worker -f
```

---

# Production Hardening

Before deploying to production, the following improvements should be implemented:

### Security

- HTTPS/TLS termination
- API authentication
- Secret management
- Role-based access control
- Vulnerability scanning

### Reliability

- Multi-AZ deployment
- Automated backups
- Health checks
- Auto healing

### Observability

- Centralized logging
- Metrics collection
- Alerting
- Distributed tracing

### Scalability

- Load balancing
- Horizontal worker scaling
- Queue-based request processing
- Autoscaling policies

---

# Scaling for a Model 100x Larger

If the language model were significantly larger:

1. GPU-enabled instances would be required.
2. Kubernetes would be used for orchestration.
3. Model sharding would be implemented.
4. Dedicated inference clusters would be created.
5. Load balancing across inference nodes would be added.
6. Distributed storage would be used.
7. Quantization and optimization techniques would be applied.
8. Multi-region deployment would be considered.

---

# Repository Structure

```text
.
├── terraform
│   ├── main.tf
│   ├── provider.tf
│   ├── network.tf
│   ├── vms.tf
│   ├── outputs.tf
│   └── variables.tf
│
├── cloud-init
│   ├── api.sh
│   ├── engine.sh
│   ├── python-worker.sh
│   └── ts-worker.sh
```

---

# Key Design Decisions

- Infrastructure managed using Terraform.
- Workers isolated in a private subnet.
- Public access restricted to API layer.
- Cross-language RPC communication between TypeScript and Python workers.
- Automated deployment through cloud-init.
- Reproducible infrastructure and application provisioning.

---

# Author

Jogendra Singh

Quick-Project Assignment Submission
