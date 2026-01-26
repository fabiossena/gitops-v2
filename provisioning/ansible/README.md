# Infrastructure Setup Guide

## Prerequisites

Requisitos

- Git
- Terraformmelhorar todo markdown
- Tested on Debian
- Testado no Debian

## 1. Ansible Setup

1. ANSIBLE

### Installation Instructions

Instalar Ansible

#### Windows (via pip)python -m pip install --upgrade pip

python -m pip install --upgrade pip
python -m pip install ansible

#### Windows (via pip)bash

````
#### Debian / Ubuntu
```bash
Debian / Ubuntu:
#### Debian / Ubuntusudo apt update
sudo apt update
sudo apt install -y software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible

#### Debian / Ubuntusudo apt --upgrade pip
python -m pip install ansible update
sudo apt install -y software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible
####
sudo apt install -y ansible
````

#### macOS (via Homebrew)brew install ansible

brew install ansible

```brew install ansible
ansible --version
```

### Prerequisites

When starting with a fresh Linux installation, if you encounter errors, run either:./scripts/00-bootstrap.sh

# OR

````
### Inventory Configuration
- Configure target hosts in `inventory/hosts.yaml`
- Alternative INI format available at `inventory/OLD_hosts.ini`

### Execution Commands

#### Standard Execution
Navigate to ansible directory:cd provisioning/ansible/
- Se preferir formato INI, há um exemplo em `inventory/OLD_hosts.ini`.
Run playbook:
```bash ansible/

Run playbook:ansible-playbook site.yml -e bootstrap_enabled=true --ask-pass --ask-become-pass

#### Tag-based Execution
```pass
Como executar (Ansible)
#### Tag-based Execution# Single tag
ansible-playbook site.yml -e bootstrap_enabled=true --ask-pass --ask-become-pass --tags [base|k3s|argocd|k9s]
Execução normal:
# Multiple tags
ansible-playbook site.yml -e bootstrap_enabled=true --ask-pass --ask-become-pass  --tags base ou k3s ou argocd ou k9s
````

#### Verification

```bash
#

#### Verification# Check configuration
```

# Check with specific inventory

ansible-playbook site.yml --ask-pass --ask-become-pass --check --diff

````
#### Rollback (Beta)
```bash

#### Rollback (Beta)ansible-playbook -i inventory/hosts.yaml playbooks/bootstrap.yml \
ansible-playbook -i inventory/hosts.yaml playbooks/bootstrap.yml \
````

## 2. Terraform Setup

### Installation Instructions

Instalar Terraform

#### Windows (via winget)winget install Hashicorp.Terraform

Windows (via winget):

#### Debian / Ubuntu

```bash
su
```

#### Debian / Ubuntusudo apt update

sudo apt update
sudo apt install -y gnupg software-properties-common curl
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor \
 -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
sudo apt update
sudo apt install -y terraform

````
### Usage Examples

#### Apply Configuration
```bash
````

#### Cleanup Usage Examples

````
#### Apply Configurationbash and Destruction
Limpeza e Destruição
##### Option 1: Complete Infrastructure Removalterraform destroy
``` Infrastructure Removalterraform destroy
**Opção 1: Destruir tudo (VMs, networks, K3s, ArgoCD)**
This will remove:
- Virtual machines/hosts
- Network configurations
- State data
Use `terraform destroy` para remover toda a infraestrutura gerenciada por Terraform:
## 3. Access and Important Commands
````

### ArgoCD Access# Get services

kubectl -n argocd get svc

- Dados de estado

# Port forwarding

kubectl -n argocd get svc
kubectl -n argocd port-forward svc/argocd-server 8080:443

# Get initial admin password

Senha inicial:
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
