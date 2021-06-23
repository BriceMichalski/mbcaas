# home-server Project

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
