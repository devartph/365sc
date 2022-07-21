# 365sc

## Testing task for 365scores

1. Infrastructure as Code (IAC) part:  
> I've used a Terraform for this part.  
> Main folder is `terraform`.  
```
─ terraform
    ├── 00_global
    │   ├── main.tf
    │   ├── terraform.tf
    │   └── variables.tf
    ├── 01_vpc
    │   ├── main.tf
    │   └── terraform.tf
    ├── 02_zone
    │   ├── main.tf
    │   └── terraform.tf
    └── 03_alb
        ├── main.tf
        ├── terraform.tf
        └── variables.tf
```
> `00_global` part use a module to create initial resources(`dynamodb table, s3 bucket and etc`) for Terraform.  
> Other folders are all about main task.

ALB endpoint: https://alb-test.test.dimash.cloudns.nz/ 




2. AWS API
>> Main folder is `awsapi`.  
```
awsapi
└── region.py
```
> I was able to finish first part of this task and some of the second part.  
> Unfortunately I don't have enough experience with AWS-API and Python to combine them in a loop.  
