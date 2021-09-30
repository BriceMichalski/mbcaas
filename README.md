# Home-caas

Ansible project for my home server installation, configuration and software deploiment

## Playbook

Only one playbook is used `playbook/home_server.yml`, it allows the configuration and deployment of my home kubernetes cluster.

## Use

Install requirements:

```bash
ansible-galaxy install -r requirements.yml
```

Launch playbook:

```bash
ansible-playbook --inventory inventories/home playbook/home_server.yml --vault-pass-file ./pwd.vault
```

To run only a part of the playbook, see the tag list.

## Tags list

> Not in execution order

|Tag Name| Usage |
|---|---|
| **prepare_server** | Configuration and customization of my server before installing kubernetes |
| **prepare_server::disk** | Part of **prepare_server** : mount and prepare my external hard drives |
| **prepare_server::swap** | Part of **prepare_server**: disable swap (kubernetes prerequisite) |
| **prepare_server::timezone** | Part of **prepare_server**: set the timezone to Europe/Paris |
| **prepare_server::upgrade** | Part of **prepare_server**: Updating packages and removing unnecessary ones |
| **prepare_server::usual** | Part of **prepare_server**: Installing utilities that I frequently use |
| **prepare_server::usual::k9s** | Part of **prepare_server::usual**: Installing k9s (kubernetes cli tools) |
| **prepare_server::usual::package** | Part of **prepare_server::usual**: Installing k9s (kubernetes cli tools) |
| **kubernetes** | Installation and configuration of the kubernetes (single-node) cluster, deployment of hosted applications |
| **kubernetes::cluster** | Part of **kubernetes** : Installation of docker and the kubernetes cluster itself |
| **kubernetes::external-dns** | Part of **kubernetes**: Configuring `external-dns` tool for dynamic declaration of hosted application dns |
| **kubernetes::ingress-controller** | Part of **kubernetes**: Installation of an ingress controller (`nginx`) for application exposure outside the cluster |
| **kubernetes::metallb** | Part of **kubernetes**: Installation of `metallb`, a load-balancer implementation for bare metal Kubernetes clusters, using standard routing protocols. |
| **kubernetes::volumes** | Part of **kubernetes**: Creation of local persistent volumes for the provision of disk space to hosted applications |
| **kubernetes::apps** | Part of **kubernetes**: Hosted Application Deployment |

## Home server spécification

My home server is a mini pc bought on amazon : [amazon link](https://www.amazon.fr/gp/product/B0919ZGR1R)

| |  |
|---|---|
| CPU | Intel Core I5-8279U - 4 Cores /  8 Threads |
| GPU | Intel Iris Plus Graphics 655 |
| Memory | 16Gb DDR4 - 2 x 8Gb |
| OS | Ubuntu 20.04.3 LTS x86_64 |

---

## Domain

- michalski.fr
- mbcaas.com

Bought on [ovh](https://www.ovh.com/fr/domaines/) and managed by [cloudflare](https://www.cloudflare.com/).
