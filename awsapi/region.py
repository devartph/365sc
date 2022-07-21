from pprint import pprint

import boto3
from botocore.exceptions import ClientError

client = boto3.client('resourcegroupstaggingapi', )
# regions = boto3.session.Session().get_available_regions('acm', allow_non_regional=False)
regions = ["us-west-2", "us-east-1"]

# Printing Region resources
for region in regions:
    print('\033[0;31m' + "The list of resources for " + region + '\033[0m')
    try:
        client = boto3.client('resourcegroupstaggingapi', region_name=region)
        pprint([x.get('ResourceARN') for x in client.get_resources().get('ResourceTagMappingList')])
    except ClientError as e:
        print(f'Could not connect to region with error: {e}')
    print()

for instances_region in regions:
    print('\033[0;31m' + "The list of Instances in " + instances_region + '\033[0m')
    EC2_RESOURCE = boto3.resource('ec2', region_name=instances_region)
    instances = EC2_RESOURCE.instances.all()
    for instance in instances:
        print(f'EC2 instance {instance.id}" information:')
        print(f'Instance state: {instance.state["Name"]}')
        print(f'Instance AMI: {instance.image.id}')
        print(f'Instance platform: {instance.platform}')
        print(f'Instance type: "{instance.instance_type}')
        print(f'Piblic IPv4 address: {instance.public_ip_address}')
        print('-'*60)


