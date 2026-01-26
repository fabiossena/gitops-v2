#!/bin/sh
set -e

ROLLBACK_FILE="/tmp/bootstrap.rollback"

rollback() {
  echo "⚠️ Rollback acionado"
  if [ -f "$ROLLBACK_FILE" ]; then
    sh "$ROLLBACK_FILE"
  fi
  exit 1
}

trap rollback ERR

echo "#!/bin/sh" > "$ROLLBACK_FILE"

echo "== TEST: systemctl =="
systemctl is-system-running || true

echo "== Atualização do sistema =="
if [ ! -f /var/lib/apt/periodic/update-success-stamp ]; then
  echo "apt update && apt upgrade" >> "$ROLLBACK_FILE"
  sudo apt update && sudo apt upgrade -y
else
  echo "Sistema já atualizado"
fi

echo "== Instalando pacotes base =="
PACKAGES="
curl wget git unzip ca-certificates
gnupg lsb-release openssh-server apt-transport-https
"

for pkg in $PACKAGES; do
  if ! dpkg -l | grep -q "^ii  $pkg "; then
    sudo apt install -y "$pkg"
    echo "sudo apt remove -y $pkg" >> "$ROLLBACK_FILE"
  else
    echo "$pkg já instalado"
  fi
done

echo "== SSH =="
sudo systemctl enable ssh
sudo systemctl start ssh

echo "== IPs =="
ip a | grep inet

echo "Bootstrap finalizado com sucesso"
rm -f "$ROLLBACK_FILE"
