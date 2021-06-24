ansible-galaxy install -r requirements.yml
ansible-playbook --inventory inventories/home/hosts playbook/home_server.yml --vault-pass-file ./pwd.vault
