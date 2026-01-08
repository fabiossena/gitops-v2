
Infra — README

Requisitos
- Git
- Terraform
- Ansible

Instalar Terraform

Windows (via winget):

```
winget install Hashicorp.Terraform
```

Debian / Ubuntu:

```
sudo apt update
sudo apt install -y gnupg software-properties-common curl
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor \
  -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
sudo apt update
sudo apt install -y terraform
terraform version
```

Configurar inventário
- Edite `inventory/hosts.yaml` com os IPs/hosts de destino.
- Se preferir formato INI, há um exemplo em `inventory/OLD_hosts.ini`.

Como executar (Ansible)

Execução normal:

```
ansible-playbook -i inventory/hosts.yaml playbooks/bootstrap.yml
```

Executar apenas uma etapa (tag):

```
ansible-playbook -i inventory/hosts.yaml playbooks/bootstrap.yml --tags ssh
```

Rollback (via Ansible):

```
ansible-playbook -i inventory/hosts.yaml playbooks/bootstrap.yml \
  --tasks-from-file roles/base/tasks/rollback.yml --tags rollback
```

Exemplos de uso com Terraform

Execução normal (Terraform irá aplicar o plano que chama Ansible):

```
terraform apply
```

Executar apenas uma etapa do Ansible através do `ansible_extra_args`:

```
terraform apply -var='ansible_extra_args=--tags ssh'
```

Executar rollback via Terraform (passando args para Ansible):

```
terraform apply -var='ansible_extra_args=--tasks-from-file roles/base/tasks/rollback.yml --tags rollback'
```

Observações
- Ajuste `inventory/hosts.yaml` antes de executar as playbooks.
- Verifique permissões/SSH entre a máquina de controle e os nós gerenciados.