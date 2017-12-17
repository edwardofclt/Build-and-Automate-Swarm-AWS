# Docker Swarm Automation on AWS

## Overview

This README will walk you through the entire process of establishing your Docker Swarm on Amazon AWS. Please feel free to submit pull requests with any improvements or additions you think necessary.

## Requirements & General FYIs

1. Python packages AWS CLI, boto3, and boto should be installed (`pip install awscli boto boto3`)
2. AWS CLI should be configured with your access keys (`aws configure`)
3. Ansible should be installed using the Ansible-provided installer (we have experienced bugs using `brew install ansible`)
4. You should have your certs and keys encrypted and stored within `secrets/certs/` within your organization's folder (i.e., secrets/certs/[org_name]/ca.pem, secrets/certs/[org_name]/key.pem, secrets/certs/[org_name]/cert.pem)
5. The `org_name` variable should be equal to the folder name within the certs folder.
6. Your Jenkins installation will need to have the corresponding password file(s) to decrypt sensitive information (i.e., UCP creds, SSL certificates, etc.)

## Quick Start Guide

You can use the following commands to get started quickly.

Name | Command | Description
--- | --- | ---
First Run | `ansible-playbook -e @vars/[var_file] --vault-password-file ~/.ssh/.passwd init_swarm.yml` | Get your swarm started. Build your ASG, LC, AMI, and SGs. ***NOTE: You will need to create the LBs.***
Create New Launch Config | `ansible-playbook -e @vars/[var_file] --vault-password-file ~/.ssh/.passwd new_launch_configs.yml` | You made modifications to the user_data file, maybe? Use this then to make sure those changes get roled out
Double the Size of The Swarm | `ansible-playbook -e @vars/[var_file] --vault-password-file ~/.ssh/.passwd update_existing_swarm.yml` | Many reasons here: 1. You're updating software. 2) Routine maintenance. 3) You need to manually scale up. This doubles the size (plus one) of that which you indicate in your organization's var file.
System Pruning | `ansible-playbook -e @vars/[var_file] --vault-password-file ~/.ssh/.passwd prune_swarm.yml` | This should be something is done regularly to ensure your Docker nodes don't get gunked up.
