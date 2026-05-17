#Infoline

Réseau VPC sur AWS 


```

  				INTERNET
                                    │
                                    ▼
                            Internet Gateway
                                    │
                                    ▼
                            VPC 10.0.0.0/16
                                    │
                    ┌───────────────┴───────────────┐
                    │                               │
                    ▼                               ▼
        Subnet DEV (eu-west-3a)         Subnet PROD (eu-west-3a)
               10.0.2.0/24                     10.0.1.0/24
                    │                               │
                    ▼                               ▼
                 SG DEV                          SG PROD
                SSH + HTTP                  SSH + HTTP + HTTPS



```
