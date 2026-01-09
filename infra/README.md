
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

Instalar Ansible

Windows (via pip):

```
python -m pip install --upgrade pip
python -m pip install ansible
ansible --version
```

Debian / Ubuntu:

```
sudo apt update
sudo apt install -y software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible
  ansible --version
```

macOS (via Homebrew):

```
brew install ansible
ansible --version
```

Configurar inventário
- Edite `infra/inventory/hosts.yaml` com os IPs/hosts de destino.
- Se preferir formato INI, há um exemplo em `infra/inventory/OLD_hosts.ini`.

Como executar (Ansible)

Execução normal:

```
ansible-playbook -i infra/ansible/inventory/hosts.yaml infra/ansible/playbooks/bootstrap.yml --ask-pass --ask-become-pass

```

Executar apenas uma etapa (tag):

```
ansible-playbook -i infra/ansible/inventory/hosts.yaml infra/ansible/playbooks/bootstrap.yml --tags ssh
```

Rollback (via Ansible):

```
ansible-playbook -i infra/ansible/inventory/hosts.yaml infra/ansible/playbooks/bootstrap.yml \
  --tasks-from-file infra/ansible/roles/base/tasks/rollback.yml --tags rollback
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

Limpeza e Destruição

**Opção 1: Destruir tudo (VMs, networks, K3s, ArgoCD)**

Use `terraform destroy` para remover toda a infraestrutura gerenciada por Terraform:

```
terraform destroy
```

Escolha `yes` quando solicitado. Isso remove:
- Máquinas virtuais/hosts
- Redes e configurações de rede
- Dados de estado

**Opção 2: Rollback parcial (remove K3s e ArgoCD, mantém SO)**

Execute rollback via Terraform/Ansible se quiser manter a infraestrutura base:

```
terraform apply -var='ansible_extra_args=--tasks-from-file infra/ansible/roles/base/tasks/rollback.yml --tags rollback'
```

Ou diretamente via Ansible:

```
ansible-playbook -i infra/ansible/inventory/hosts.yaml infra/ansible/playbooks/bootstrap.yml \
  --tasks-from-file infra/ansible/roles/base/tasks/rollback.yml --tags rollback
```

Isso:
- Remove ArgoCD namespace
- Executa `k3s-uninstall.sh` (limpeza oficial do K3s)
- Desativa SSH
- Remove pacotes base

**Opção 3: Apenas uninstalar K3s (manual)**

Se estiver logado no host destino:

```
/usr/local/bin/k3s-uninstall.sh
```

Observações
- Ajuste `infra/inventory/hosts.yaml` antes de executar as playbooks.
- Verifique permissões/SSH entre a máquina de controle e os nós gerenciados.