# InfoLine

```Architecture du VPC 

                 INTERNET
                     │
             Internet Gateway
                     │
              VPC 10.0.0.0/16
                     │
        ┌────────────┴────────────┐
        │                         │
  Subnet DEV                Subnet PROD
   10.0.1.0/24              10.0.2.0/24
   eu-west-3a               eu-west-3a
        │                         │
   SG DEV                    SG PROD
   SSH + HTTP          SSH + HTTP + HTTPS
```
