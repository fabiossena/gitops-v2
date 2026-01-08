
Instalar terraform no windows
winget install Hashicorp.Terraform

Configurar IP da maquina destino no hosts.ini

sudo apt update
sudo apt install -y gnupg software-properties-common curl

curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

sudo apt update
sudo apt install terraform

terraform version


# formatar
▶️ Como executar
Execução normal
ansible-playbook -i inventory/hosts.ini playbooks/bootstrap.yml

Executar só uma etapa
ansible-playbook playbooks/bootstrap.yml --tags ssh

🔥 Rollback
ansible-playbook playbooks/bootstrap.yml \
  --tasks-from-file roles/base/tasks/rollback.yml \
  --tags rollback



  ▶️ Exemplos de uso
Execução normal
terraform apply

Executar só uma etapa do Ansible
terraform apply \
  -var='ansible_extra_args=--tags ssh'

Executar rollback via Terraform
terraform apply \
  -var='ansible_extra_args=--tasks-from-file roles/base/tasks/rollback.yml --tags rollback'