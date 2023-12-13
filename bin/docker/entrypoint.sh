#!/bin/bash

tsh login --proxy=teleport.mbcaas.com:443 --auth=local --user=$1 teleport.mbcaas.com 1>/dev/null

if [ $? -ne 0 ]; then
    echo "Authentification Failed"
    exit 1
fi

tsh kube login teleport.mbcaas.com  2>&1 > /dev/null
tsh proxy kube -p 443  2>&1 > /dev/null &
sleep 2
echo -e "\n"

export KUBECONFIG=/home/mbcaas-tools/.tsh/keys/teleport.mbcaas.com/$MBCAAS_USER-kube/teleport.mbcaas.com/localproxy-443-kubeconfig
kubectl get ns > /dev/null 2>&1

exec /bin/bash -l
