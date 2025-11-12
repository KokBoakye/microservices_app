# 🧩 Microservices Application on AWS (FastAPI + ECS + Terraform)

This project demonstrates a **microservices architecture** deployed to **AWS ECS Fargate** using **Terraform** for infrastructure provisioning and **GitHub Actions** for CI/CD.  

It includes three core FastAPI services:
- **User Service** — manages user data
- **Order Service** — manages orders
- **API Gateway** — routes external requests to internal services

---

## 🚀 Architecture Overview

**Infrastructure Stack**
- **AWS ECS Fargate** — container orchestration
- **AWS ECR** — container registry
- **AWS VPC** — isolated network environment
- **ALB (Application Load Balancer)** — routes external HTTP traffic
- **Service Discovery (AWS Cloud Map)** — enables internal service-to-service communication
- **NAT Gateway + IGW** — outbound internet access for private subnets
- **Terraform** — Infrastructure as Code (IaC)
- **GitHub Actions** — CI/CD automation

**Service Communication**
- ALB → API Gateway (port `8000`)
- API Gateway → User Service (port `8001`)
- API Gateway → Order Service (port `8002`)
- Services discover each other via AWS Cloud Map internal DNS  
  (`user-service.internal.local`, `order-service.internal.local`)

---

## 🏗️ Repository Structure

microservices/
├── api_gateway/ # FastAPI API Gateway service
│ ├── app.py
│ ├── requirements.txt
│ ├── Dockerfile
│ └── venv/ # Local virtual environment (ignored in build)
│
├── user_service/ # FastAPI User Service
│ ├── app.py
│ ├── database.py
│ ├── models.py
│ ├── requirements.txt
│ └── Dockerfile
│
├── order_service/ # FastAPI Order Service
│ ├── app.py
│ ├── database.py
│ ├── models.py
│ ├── requirements.txt
│ └── Dockerfile
│
└── terraform/ # Infrastructure as Code
├── deployment/ # Environment-specific configs
│ ├── main.tf
│ ├── provider.tf
│ ├── variables.tf
│ ├── dev.tfvars
│ └── outputs.tf
└── modules/
├── alb/
├── ecr/
├── ecs/
└── vpc/

---

## ⚙️ Local Development

### 1️⃣ Setup Virtual Environments (optional for local testing)
```bash
cd user_service
python3 -m venv venv && source venv/bin/activate
pip install -r requirements.txt
uvicorn app:app --reload --port 8001
Repeat for order_service and api_gateway (use ports 8002 and 8000 respectively).
🐳 Docker Build & Run
Each service has its own Dockerfile.
Build and run locally:
docker build -t user-service ./user_service
docker run -p 8001:8001 user-service
☁️ Deployment to AWS
1️⃣ Push Docker images to ECR
aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <account-id>.dkr.ecr.<region>.amazonaws.com
docker build -t user-service ./user_service
docker tag user-service <account-id>.dkr.ecr.<region>.amazonaws.com/user-service:latest
docker push <account-id>.dkr.ecr.<region>.amazonaws.com/user-service:latest
2️⃣ Deploy Infrastructure with Terraform
cd terraform/deployment
terraform init
terraform apply -var-file=dev.tfvars
This provisions:
VPC (2 public + 2 private subnets)
ALB + Target Groups
ECS Cluster & Fargate Services
NAT Gateways
Security Groups
Service Discovery (Cloud Map)
3️⃣ Continuous Deployment via GitHub Actions
On every push to main, GitHub Actions:
Builds Docker images for all services.
Pushes them to ECR.
Deploys ECS task definitions via Terraform.
🔐 Networking Summary
Component	Subnet Type	Description
ALB	Public	Exposes entrypoint to internet
NAT Gateway	Public	Enables internet access for private ECS tasks
ECS Services	Private	Internal communication only
Cloud Map	Private DNS	Service discovery inside the VPC
🧠 Troubleshooting Summary
Issue	Cause	Fix
504 Gateway Timeout	API Gateway couldn’t reach internal services	Added NAT, fixed SG rules, ensured health check path
Service not starting	Wrong image tag or missing CMD	Corrected Docker CMD & tags
ECS task draining	Terraform re-applied too fast	Waited for task drain or force-delete old
“/openapi.json” error	Swagger timed out	Confirmed internal routing and health endpoint
NAT routing	Wrong route table setup	Linked private RT to NAT gateway
Full troubleshooting details are in TROUBLESHOOTING.md (optional to create).


🧾 Environment Variables
Each service can define the following (if needed):
DATABASE_URL=postgresql://user:pass@db:5432/dbname
USER_SERVICE_URL=http://user-service.internal.local
ORDER_SERVICE_URL=http://order-service.internal.local
🧪 Testing API Endpoints
Once deployed, open:
Swagger UI:
http://<ALB-DNS-Name>/docs

Example requests:

GET  /users
POST /users
GET  /orders
POST /orders
🧹 Cleanup
To destroy infrastructure:
cd terraform/deployment
terraform destroy -var-file=dev.tfvars
🏁 Status
✅ Multi-service FastAPI system
✅ Fully automated infrastructure (Terraform + GitHub Actions)
✅ High-availability ECS architecture
✅ Secure internal communication via service discovery

👤 Author
Kwabena Okyere Boakye
