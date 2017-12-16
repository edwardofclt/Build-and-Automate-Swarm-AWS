#cloud-boothook
#!/bin/bash

sleep 120

nodeIp=$(ip addr | grep 'dynamic eth0' | awk -F 'inet ' '{print $2}' | awk -F '/25' '{print $1}')

# Use postman to generate authorization token for you
curl --request POST \
   --url 'http://<JENKINS_URL>/job/AWS-Automation/job/Build%20AWS%20Swarm/job/master/build?delay=0sec' \
   --header 'authorization: Basic <POSTMAN_AUTH_TOKEN>' \
   --header 'cache-control: no-cache' \
   --data-urlencode json="{'parameter': [{'name': 'nodeIp', 'value':'${nodeIp}'}, {'name': 'job', 'value': 'dtr'}, {'name': 'org', 'value': '<ORG_PREFIX>'}]}"
