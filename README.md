# MBCaaS

[![Continuous Integration](https://github.com/BriceMichalski/mbcaas/actions/workflows/ci.yml/badge.svg)](https://github.com/BriceMichalski/mbcaas/actions/workflows/ci.yml)

My self hosted kubernetes cluster.

## Hosted Domain

- michalski.fr
- mbcaas.com

## Bare Metal

### Hardware
This single node cluster running on a mini pc bought on amazon : [amazon link](https://www.amazon.fr/gp/product/B0919ZGR1R)

| <!-- -->    | <!-- -->    |
|---|---|
| CPU | Intel Core I5-8279U - 4 Cores /  8 Threads |
| GPU | Intel Iris Plus Graphics 655 |
| Memory | 16Gb DDR4 - 2 x 8Gb |


I hope i can add few node to this cluster along time. I don't have and probably never will have the need for it but it's just for fun.

### OS

For the opérating system i chose Ubuntu 20.04.3 LTS x86_64, for multiple reason.
First, the ease of installation, download ISO, copy it on my [Ventoy](https://www.ventoy.net/en/index.html) usb key, start my computer and chose ubuntu in the boot menu. After that the ubuntu installer will do the glue.

The seconds reason is: i'm a really lazy. For my needs, i found all code for install docker / kubernetes on ansible galaxy.
And when i say "ansible galaxy", i mean [Jeff Geerling](https://github.com/geerlingguy). Why spend time writing code when much more competent guys share theirs?
Thanks for your work.
When i start this project, it seems to me that the roles I needed recommended to use Ubuntu Focal. But maybe it's not true and I chose this distribution arbitrarily.

### Provisioning.

For the hardening of my cluster i wrote a [hardening ansible role](infrastructure/bare-metal/roles/hardening) that handle following stuff:

- System upgrade
- Server Timezone
- SSH user and private key
- Disks Partitions
- SWAP ( disable for kubernetes )
- Install some usual tools I use like `jq`.

And an [ansible playbook](./infrastructure/bare-metal/playbook/infrastructure.yml) that launch the following role:

- My custom hardening role
- [geerlingguy.nfs](https://github.com/geerlingguy/ansible-role-nfs)
- [geerlingguy.docker](https://github.com/geerlingguy/ansible-role-docker)
- [geerlingguy.helm](https://github.com/geerlingguy/ansible-role-helm)
- [geerlingguy.kubernetes](https://github.com/geerlingguy/ansible-role-kubernetes)

For the 3 first role, the default value work well for me, but for kubernetes install I need to change some parameters.
In my case, you can find my parameters in [this files](./infrastructure/bare-metal/playbook/group_vars/all/kubernetes.yml).
This is probably not following all the best practice, but it's working for me like that.
For all your case, use the [Kubernetes documentation](https://kubernetes.io/docs/home/)

### Self hosted consideration

The goal of this self hosted cluster, it's to give me the opportunity to build web server from scratch (Playing first and foremost in reality).
Like all Internet Service Provider, my ISP give me a public IP on WAN, i can found this IP in my router configuration interface.
For now when i call this ip, nothing respond me. I need to set up à port forwarding between my ISP box and my single node.
In my case, and because i user my ISP box on `router` mode and not as `bridge` with some professional router behind, this step is manual and can be done on my ISP router configuration interface. For the moment i just want to allow HTTPS flow, so i open the port `443` of my box and forward it to my home server.



```
 ___________            ___________              ____________
|           |          |           |            |            |
|    WAN    | ----> :443  ISP BOX  | ----> :30443 Master Node|
|___________|          |___________|            |____________|

```


## Kubernetes Cluster




## PlaybookIl

- `playbook/infrastructure.yml`: it allows the configuration and deployment of my home kubernetes cluster.
- `playbook/applications.yml`: deploy all my apps on kubernetes cluster

## How to use it

Install requirements:

```bash
ansible-galaxy install -r requirements.yml
```

Launch playbook:

```bash
ansible-playbook --inventory inventories/prod/hosts playbook/infrastructure.yml --vault-pass-file ./pwd.vault
ansible-playbook --inventory inventories/prod/hosts playbook/applications.yml --vault-pass-file ./pwd.vault
```

## Infrastructure playbook tags list in execution order

|     Tag Name                      | What it does    |
|     ---                           | ---               |
|     **HARDENING**                 |                   |
|     hardening::users              |  Manage users, privileges and ssh keys |
|     hardening::timezone           |  Set Timezone to Europe/Paris |
|     hardening::upgrade            |  Updating system packages and removing unnecessary ones |
|     hardening::partition          |  Manage disks, partitions, mountpoint |
|     hardening::backup             |  Deploy backup script |
|     hardening::swap               |  Disable swap (kubernetes prerequisite) |
|     hardening::usual              |  Installing utilities that I frequently use |
|     ---                           |                   |
|     **NFS**                       |  Install nfs server and expose partitions |
|     ---                           |                   |
|     **KUBERNETES**                |                   |
|     kubernetes::cluster           |  Install raw Kubernetes using [geerlingguy's](https://github.com/geerlingguy) roles |
|     kubernetes::core              |  Installation and configuration of my core platform including storage class, metallb, traefik, cert-manager, external-dns, prometheus stack and portainer |
|     kubernetes::data              |  Installation and configuration of shared database. [Documentation](./docs/database.md) |
|     kubernetes::gitops            |  Installation and configuration  of gitops part of my plateforme using argocd |
|     kubernetes::portal            |  Intallation of my homelab portal using [homer](https://github.com/bastienwirtz/homer) |




- on-mange-quoi.com

Managed by [cloudflare](https://www.cloudflare.com/).

## Usefull link

- [Nginx Ingress controller](https://kubernetes.github.io/ingress-nginx/)
- [Nginx ingress controller - baremetal considerations](https://kubernetes.github.io/ingress-nginx/deploy/baremetal/)
- [Metallb installation](https://metallb.universe.tf/installation/)
- [External-dns](https://github.com/kubernetes-sigs/external-dns)
- [External-dns with Cloudflare](https://github.com/kubernetes-sigs/external-dns/blob/master/docs/tutorials/cloudflare.md)
- [Cloudflare token generation](https://support.cloudflare.com/hc/fr-fr/articles/200167836-Gestion-des-jetons-et-cl%C3%A9s-de-l-API#12345680)
- [Force External-dns to target my internet box public IP](https://github.com/kubernetes-sigs/external-dns/blob/master/docs/faq.md#are-other-ingress-controllers-supported)
- [Cert Manager install](https://cert-manager.io/docs/installation/)
- [Cert Manager LetsEncrypt ACME](https://cert-manager.io/docs/configuration/acme/)
- [Cert Manager DNS01 Challenge with cloudflare](https://cert-manager.io/docs/configuration/acme/dns01/cloudflare/)
