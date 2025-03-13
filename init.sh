#!/bin/bash

set -e

# Aggiorna il sistema
echo "Aggiornamento del sistema..."
sudo apt update && sudo apt upgrade -y

# Installa UI Deepin
echo "Installazione di Gnome..."
sudo sudo apt install -y ubuntu-gnome-desktop gdm3

# Installa accesso remoto (xrdp)
echo "Installazione di XRDP..."
sudo apt install -y xrdp
sudo systemctl enable --now xrdp
sudo systemctl start xrdp
sudo ufw allow 3389/tcp

# Installa Google Chrome
echo "Installazione di Google Chrome..."
wget -q -O chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i chrome.deb || sudo apt install -f -y
rm chrome.deb

# Installa GIT
echo "Installazione di Git..."
sudo apt install -y git

# Installa VSCode
echo "Installazione di Visual Studio Code..."
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install -y code

# Installa IntelliJ IDEA
echo "Installazione di IntelliJ IDEA..."
wget -q -O idea.tar.gz https://download.jetbrains.com/idea/ideaIC-2024.3.4.1.tar.gz
sudo tar -xzf idea.tar.gz -C /opt/
sudo ln -s /opt/idea-*/bin/idea.sh /usr/local/bin/intellij
rm idea.tar.gz

# Installa Java 21
echo "Installazione di OpenJDK 21..."
sudo apt install -y openjdk-21-jdk

# Installa Maven
echo "Installazione di Maven..."
sudo apt install -y maven

# Installa Node.js e PNPM
echo "Installazione di Node.js e PNPM..."
sudo apt install -y nodejs npm
sudo npm install -g pnpm

# Installa Docker
echo "Installazione di Docker..."
sudo apt update
sudo apt install -y ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo tee /etc/apt/keyrings/docker.asc > /dev/null
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Permetti a tutti gli utenti di accedere a Docker senza sudo
echo "Configurazione dei permessi per Docker..."
sudo groupadd -f docker
sudo chmod 666 /var/run/docker.sock

# Installa AZCLI
echo "Installazione di AZCLI"
sudo apt install -y ca-certificates curl apt-transport-https lsb-release gnupg
curl -sL https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor -o /usr/share/keyrings/microsoft-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft-archive-keyring.gpg] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/azure-cli.list
sudo apt update
sudo apt install -y azure-cli
az version

# Installazione Kubectl
echo "Installazione kubectl"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl

# Installa Helm
echo "Installazione helm"
curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Installa Python
echo "Installazione di Python e pip..."
sudo apt install -y python3 python3-pip

# Installa OpenVPN
echo "Installazione di OpenVPN..."
sudo apt install -y openvpn

echo "Installazione completata!"
