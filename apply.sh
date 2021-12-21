ansible-galaxy install -r requirements.yml
ansible-playbook --inventory inventories/prod/hosts playbook/home_servers.yml --vault-pass-file ./pwd.vault
