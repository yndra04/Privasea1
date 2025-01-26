#!/bin/bash
echo "   ______ _____   ___  ____  __________  __ ____  _____ "
echo "  / __/ // / _ | / _ \/ __/ /  _/_  __/ / // / / / / _ )"
echo " _\ \/ _  / __ |/ , _/ _/  _/ /  / /   / _  / /_/ / _  |"
echo "/___/_//_/_/ |_/_/|_/___/ /___/ /_/   /_//_/\____/____/ "
echo "               PRIVASEA NODE                            "
sleep 3

source <(wget -O - https://raw.githubusercontent.com/shareithub/Privasea/refs/heads/main/privasea.sh)

mkdir -p ~/privasea/config && cd ~/privasea

echo "Masukkan isi wallet_keystore Anda:"
read wallet_keystore_content

echo "$wallet_keystore_content" > ~/privasea/config/wallet_keystore

echo "File wallet_keystore telah berhasil dibuat di ~/privasea/config"

echo "Menarik Docker image privasea/acceleration-node-beta:latest..."
docker pull privasea/acceleration-node-beta:latest

echo "Docker image privasea/acceleration-node-beta:latest telah berhasil ditarik."

echo "Masukkan KEYSTORE_PASSWORD Anda:"
read -s KEYSTORE_PASSWORD  

echo "Menjalankan Docker container privanetix-node..."
docker run -d --name privanetix-node -v "$HOME/privasea/config:/app/config" -e KEYSTORE_PASSWORD=$KEYSTORE_PASSWORD privasea/acceleration-node-beta:latest

echo "Docker container privanetix-node telah berhasil dijalankan."

echo "Merestart Docker container privanetix-node..."
docker restart privanetix-node

echo "Docker container privanetix-node telah berhasil di-restart."

echo "Menampilkan log dari Docker container privanetix-node..."
docker logs privanetix-node

echo "Log dari Docker container privanetix-node telah ditampilkan."
