# 365sc

## Testing task for 365scores

1. Infrastructure as Code (IAC) part:  
> I've used a Terraform for this part.  
```
Actually, I did the first part, I had some troubles with the domain and certificate,  
I did it through the free zone, but catched a situation when the zone was in black 
lists and was not able to propagate around the world, or rather in the US zone, 
and without this it was impossible to validate the certificate for the load balancer regarding our task, 
killed half a day until I realized where the reason was and did not use the domain in another zone.
```
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
> The Output:
```
python3 region.py                                                                                                                                                                                    ─╯
The list of resources for us-west-2
['arn:aws:ec2:us-west-2:780616323728:security-group/sg-0266e2f77c1733000',
 'arn:aws:ec2:us-west-2:780616323728:subnet/subnet-0f931fa6e80e5fc43',
 'arn:aws:elasticloadbalancing:us-west-2:780616323728:targetgroup/albtg/fbea43e6a7d84e05',
 'arn:aws:ec2:us-west-2:780616323728:internet-gateway/igw-096ddfa88f060c8ca',
 'arn:aws:ec2:us-west-2:780616323728:route-table/rtb-064353c349c743cca',
 'arn:aws:ec2:us-west-2:780616323728:route-table/rtb-0eb586470ba40ce06',
 'arn:aws:ec2:us-west-2:780616323728:subnet/subnet-037824c547617913f',
 'arn:aws:ec2:us-west-2:780616323728:vpc/vpc-0a492f221d3412d80',
 'arn:aws:acm:us-west-2:780616323728:certificate/9bb2688e-e351-47d2-b515-663383e0bc2d',
 'arn:aws:ec2:us-west-2:780616323728:instance/i-00abaf7a055d3ec42',
 'arn:aws:ec2:us-west-2:780616323728:subnet/subnet-0f8543b50e95a2a55',
 'arn:aws:elasticloadbalancing:us-west-2:780616323728:loadbalancer/app/alb-test/a9f3e377da2850b3',
 'arn:aws:ec2:us-west-2:780616323728:subnet/subnet-09f4f5b6b327eb492']

The list of resources for us-east-1
['arn:aws:route53:::hostedzone/Z0628016K380J9ZRCU92',
 'arn:aws:route53:::hostedzone/Z0450179341B636SUD8SQ']

The list of Instances in us-west-2
EC2 instance i-00abaf7a055d3ec42" information:
Instance state: running
Instance AMI: ami-00f005e395638ae78
Instance platform: None
Instance type: "t3a.nano
Piblic IPv4 address: 35.163.32.121
------------------------------------------------------------
```
```
I did a half of the second part. Started the second part and realized that I can’t beautifully 
connect the conclusions of the first part of the script and a bunch of cycles from second part of our task , 
unfortunately I don’t have enough experience with Python scripting, I understand that I’ll figure it out 
for sure but I don’t know how much time I’ll kill for this.
``` 

3. Conclusions:
> Infrastructure is up and running of the moment. Please don't forgot to do `terraform destroy` after checking, terraform state are on S3 bucket and you would not have any troubles with this.  
> In any case it was interesting for me, I took out something useful for myself and once again saw that Python skills needs to be raised.
  
> Also wants to say Thank You for granting me a chance for this challenge.
