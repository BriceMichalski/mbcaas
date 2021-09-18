# home-caas Project

Ansible project for my home server installation & configuration

## Use

Write the vault password in `pwd.vault` file:

```bash
echo VAULT_PASS > pwd.vault
```

Install requirements:

```bash
ansible-galaxy install -r requirements.yml
```

Launch playbook `home-server.yml`:

```bash
ansible-playbook --inventory inventories/home playbook/home_server.yml --vault-pass-file ./pwd.vault
```

App only:

```bash
ansible-playbook --inventory inventories/home/hosts playbook/home_server.yml --vault-pass-file ./pwd.vault --tags kubernetes::apps
```

## what does the playbook home_server.yml do ?

1. Sets timezone to `Europe/Paris`
2. System update and upgrade
3. Disable swap
4. Installs some usual command like `jq`,`git`,`nmap` or `k9s`
5. Manage user rights and their ssh public key
6. Installs Docker
7. Installs Kubernetes and start a single-node cluster.
