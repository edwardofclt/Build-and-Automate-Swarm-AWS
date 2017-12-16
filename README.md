# Ansibilized Automation for Docker Swarms

## Overview

This README will walk you through the entire process of establishing your Docker Swarm on Amazon AWS.

## Requirements & Notes

1. Python packages AWS CLI, boto3, and boto should be installed (`pip install awscli boto boto3`)
2. AWS CLI should be configured with your access keys (`aws configure`)
3. Ansible should be installed using the Ansible-provided installer (we have experienced bugs using `brew install ansible`)
4. You should have your certs and keys encrypted and stored within `secrets/certs/` within your organization's folder (i.e., secrets/certs/[org_name]/ca.pem, secrets/certs/[org_name]/key.pem, secrets/certs/[org_name]/cert.pem)
5. The `org_name` variable should be equal to the folder name within the certs folder.

### Use Cases

#### Setup the requirements for the swarm (excludes LB configuration)

**Note:** *In this example we have encrypted our variable files for security reasons. We are using the `.passwd` file to decrypt the necessary values.*

1. Go into `vars/` and modify the corresponding file for your organization
2. Run `ansible-playbook -e @vars/[var_file] --vault-password-file ~/.ssh/.passwd first_run.yml`

#### Initialization of the swarm (including UCP and DTR)

`ansible-playbook -e @vars/[var_file] --vault-password-file ~/.ssh/.passwd init_swarm.yml`
