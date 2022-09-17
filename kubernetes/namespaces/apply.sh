#!/bin/bash
j2 -f yaml template.yml.j2 config.yml -o /tmp/ns.yml
kubectl apply -f /tmp/ns.yml 2> /dev/null
rm -f /tmp/ns.yml