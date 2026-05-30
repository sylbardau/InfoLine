# InfoLine – Infrastructure DevOps

> TP Administrateur Système DevOps 

## Présentation

InfoLine est une agence spécialisée dans l'actualité des technologies sportives connectées.  
Ce dépôt contient l'infrastructure as code et les scripts CI/CD permettant de déployer la plateforme sur AWS.

---

## Branches

 Branche =  Rôle
 `main` = Code pret pour la mise en production 
 `develop`= developpement du projet en cours avant aprobation

---

## Avancement du projet

### ✅ AT1 — Automatisation de l'infrastructure Cloud (Terraform)

| Composant | Statut | Détails |
|-----------|--------|---------|
| VPC | ✅ Terminé | 2 subnets publics + 2 privés, NAT Gateway, IGW, route tables, security groups |
| EKS (Kubernetes) | ✅ Terminé | Cluster `infoline-eks` v1.31, node group auto-scaling (1–3 × t3.small), IAM roles |
| Lambda (Serverless) | ✅ Terminé | Fonction Python `infoline-login`, API Gateway REST `/login`, DynamoDB `infoline-users` |
| RDS PostgreSQL | ✅ Terminé | Instance `db.t3.micro`, PostgreSQL 15.6, subnet group privé, chiffrement activé |

**Stack Terraform :**
```
providers.tf      → AWS provider (eu-west-3)
variable.tf       → Variables globales
terraform.tfvars  → Valeurs de déploiement
main.tf           → Modules VPC / EKS / Lambda / RDS
outputs.tf        → Sorties (endpoints, IDs, noms)
```
