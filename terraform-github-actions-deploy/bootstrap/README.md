# 🔐 AWS OIDC Bootstrap Setup (Terraform)

This folder bootstraps the **AWS OpenID Connect (OIDC)** trust configuration and **Terraform remote state backend** that enables secure, automated infrastructure deployment via **GitHub Actions**.

## 📘 Overview

This bootstrap performs a **one-time setup** in your AWS account to enable:
- **Secure OIDC authentication** for GitHub Actions (no long-lived AWS keys)
- **Remote state management** with S3 and DynamoDB for Terraform Cloud integration

### Resources Created:

1. **OIDC Provider** for GitHub (`token.actions.githubusercontent.com`)
2. **IAM Role** with GitHub repository trust policy
3. **S3 Bucket** for Terraform state storage with versioning and encryption
4. **DynamoDB Table** for Terraform state locking and consistency
5. **IAM Policies** for secure state management

After this setup:
- All CI/CD pipelines use the OIDC role directly for Terraform operations
- Terraform state is securely stored in S3 with DynamoDB locking
- Multiple team members can collaborate safely on infrastructure

## 🔒 Security Features

* **Repository-scoped access**: IAM Role trust policy limits access to your specific GitHub repository
* **State encryption**: S3 bucket uses server-side encryption
* **State locking**: DynamoDB prevents concurrent modifications
* **Short-lived tokens**: AWS STS provides auto-rotated credentials

```hcl
"StringLike": {
  "token.actions.githubusercontent.com:sub": "repo:<ORG>/<REPO>:*"
}
```

## 🚀 Usage

```bash
cd bootstrap
terraform init
terraform plan
terraform apply
```

---

🧩 *Once applied, your GitHub repository becomes a trusted OIDC identity with secure remote state management.*
