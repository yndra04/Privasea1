#!/bin/bash
echo "   ______ _____   ___  ____  __________  __ ____  _____ "
echo "  / __/ // / _ | / _ \/ __/ /  _/_  __/ / // / / / / _ )"
echo " _\ \/ _  / __ |/ , _/ _/  _/ /  / /   / _  / /_/ / _  |"
echo "/___/_//_/_/ |_/_/|_/___/ /___/ /_/   /_//_/\____/____/ "
echo "               PRIVASEA NODE                            "
sleep 3

sudo groupadd docker && sudo usermod -aG docker $(whoami) && newgrp docker
sleep 5

source <(wget -O - https://raw.githubusercontent.com/shareithub/Privasea/refs/heads/main/privasea.sh)
sleep 5

mkdir -p ~/privasea/config && cd ~/privasea
sleep 5

echo "Masukkan isi wallet_keystore Anda:"
read wallet_keystore_content
sleep 5

echo "$wallet_keystore_content" > ~/privasea/config/wallet_keystore
sleep5

echo "File wallet_keystore telah berhasil dibuat di ~/privasea/config"
sleep 5

echo "Menarik Docker image privasea/acceleration-node-beta:latest..."
docker pull privasea/acceleration-node-beta:latest

echo "Docker image privasea/acceleration-node-beta:latest telah berhasil ditarik."

echo "Masukkan KEYSTORE_PASSWORD Anda:"
read -s KEYSTORE_PASSWORD  
sleep 5
echo "Menjalankan Docker container privanetix-node..."
docker run -d --name privanetix-node -v "$HOME/privasea/config:/app/config" -e KEYSTORE_PASSWORD=$KEYSTORE_PASSWORD privasea/acceleration-node-beta:latest
sleep 5
echo "Docker container privanetix-node telah berhasil dijalankan."
sleep 5
echo "Merestart Docker container privanetix-node..."
docker restart privanetix-node
sleep 5
echo "Docker container privanetix-node telah berhasil di-restart."
sleep 5
echo "Menampilkan log dari Docker container privanetix-node..."
docker logs privanetix-node
sleep 5
echo "Log dari Docker container privanetix-node telah ditampilkan."
