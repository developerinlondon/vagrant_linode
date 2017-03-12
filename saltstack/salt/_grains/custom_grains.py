#!/usr/bin/env python
# import subprocess

# def customgrains():
#      # initialize a grains dictionary
#      grains = {}
#      awsinstanceid = subprocess.check_output("""wget -qO- http://instance-data/latest/meta-data/instance-id""", shell=True)
#      awsregion = subprocess.check_output("""wget -qO- http://instance-data/latest/meta-data/placement/availability-zone | sed -e 's:\([0-9][0-9]*\)[a-z]*\$:\\1:' """, shell=True)[:-1]
#      awsvpc = subprocess.check_output("""aws ec2 describe-tags --filters "Name=resource-id,Values="""+str(awsinstanceid)+"""" "Name=key,Values=VPC" --region """+str(awsregion)+""" --query 'Tags[*].Value' --output text""", shell=True)[:-1]
#      saltmaster = subprocess.check_output("""sudo aws ec2 describe-instances --region="""+str(awsregion)+""" --filters Name=tag:Name,Values="""+str(awsvpc)+""".saltmaster* --query 'Reservations[*].Instances[*].NetworkInterfaces[*].PrivateIpAddress' --output text | tail""", shell=True)[:-1]
#      grains['vpc'] = awsvpc
#      grains['region'] = awsregion
#      grains['kubemaster'] = kubemaster
#      grains['saltmaster'] = saltmaster
#      grains['awsregion'] = awsregion
#      grains['etcdauthority'] = str(kubemaster)+":6666"
#      return grains


#!/usr/bin/env python
import subprocess

def customgrains():
     # initialize a grains dictionary
     grains = {}
     # awsinstanceid = subprocess.check_output("""wget -qO- http://169.254.169.254/latest/meta-data/instance-id""", shell=True)
     # awsregion = subprocess.check_output("""wget -qO- http://169.254.169.254/latest/meta-data/placement/availability-zone | sed -e 's:\([0-9][0-9]*\)[a-z]*\$:\\1:' """, shell=True)[:-1]
     # awsvpc = subprocess.check_output("""aws ec2 describe-tags --filters "Name=resource-id,Values="""+str(awsinstanceid)+"""" "Name=key,Values=VPC" --region """+str(awsregion)+""" --query 'Tags[*].Value' --output text""", shell=True)[:-1]
     # private_domain = subprocess.check_output("""aws ec2 describe-tags --filters "Name=resource-id,Values="""+str(awsinstanceid)+"""" "Name=key,Values=PrivateDomain" --region """+str(awsregion)+""" --query 'Tags[*].Value' --output text""", shell=True)[:-1]
     # public_domain = subprocess.check_output("""aws ec2 describe-tags --filters "Name=resource-id,Values="""+str(awsinstanceid)+"""" "Name=key,Values=PublicDomain" --region """+str(awsregion)+""" --query 'Tags[*].Value' --output text""", shell=True)[:-1]
     prompt_color = "32" # subprocess.check_output("""aws ec2 describe-tags --filters "Name=resource-id,Values="""+str(awsinstanceid)+"""" "Name=key,Values=PromptColor" --region """+str(awsregion)+""" --query 'Tags[*].Value' --output text""", shell=True)[:-1]

     # kubemaster = subprocess.check_output("""aws ec2 describe-instances --region="""+str(awsregion)+""" --filters Name=tag:Name,Values=kubemaster* Name=tag:VPC,Values="""+str(awsvpc)+""" --query 'Reservations[*].Instances[*].NetworkInterfaces[*].PrivateIpAddress' --output text | tail""", shell=True)[:-1]
     # saltmaster = "saltmaster."+str(awsvpc)+"."+str(private_domain)
     # grains['vpc'] = awsvpc
     # grains['region'] = awsregion
     # grains['kubemaster'] = kubemaster
     # grains['saltmaster'] = saltmaster
     # grains['awsregion'] = awsregion
     # grains['private_domain'] = private_domain
     # grains['public_domain'] = public_domain
     # grains['etcdauthority'] = str(kubemaster)+":6666"
     grains['prompt_color'] = str(prompt_color)
     return grains
