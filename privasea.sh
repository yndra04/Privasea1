#!/bin/bash
echo "   ______ _____   ___  ____  __________  __ ____  _____ "
echo "  / __/ // / _ | / _ \/ __/ /  _/_  __/ / // / / / / _ )"
echo " _\ \/ _  / __ |/ , _/ _/  _/ /  / /   / _  / /_/ / _  |"
echo "/___/_//_/_/ |_/_/|_/___/ /___/ /_/   /_//_/\____/____/ "
echo "               PRIVASEA NODE                            "
sleep 3

echo "Membuat direktori ~/privasea1/config..."
sudo mkdir -p ~/privasea1/config

echo "Menunggu 3 detik..."
sleep 3

echo "Masukkan isi untuk file 'wallet_keystore':"
read -p "Masukkan data wallet: " wallet_data
clear
echo "$wallet_data" > ~/privasea1/config/wallet_keystore
echo "File 'wallet_keystore' berhasil dibuat di ~/privasea1/config."

echo "Masukkan informasi keystore baru..."
echo "Masukkan password untuk keystore: "
read -sp "Password: " KEYSTORE_PASSWORD

echo "Menunggu 3 detik..."
sleep 3

echo "Starting your Privasea Privanetix Node..."
sudo docker run -d --name privanetix-node1 -v "$HOME/privasea1/config:/app/config" -e KEYSTORE_PASSWORD=$KEYSTORE_PASSWORD privasea/acceleration-node-beta
sleep 5

sudo docker restart privanetix-node1
sleep 5

sudo docker logs privanetix-node1
sleep 1

echo "Node setup is complete! Don't forget to Subscribe, like & share Youtube: SHARE IT HUB."
