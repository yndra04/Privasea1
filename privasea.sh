#!/bin/bash
echo "   ______ _____   ___  ____  __________  __ ____  _____ "
echo "  / __/ // / _ | / _ \/ __/ /  _/_  __/ / // / / / / _ )"
echo " _\ \/ _  / __ |/ , _/ _/  _/ /  / /   / _  / /_/ / _  |"
echo "/___/_//_/_/ |_/_/|_/___/ /___/ /_/   /_//_/\____/____/ "
echo "               SUBSCRIBE MY CHANNEL                     "
sleep 3

    echo "Mengatur Docker dalam rootless mode..."
    sudo apt-get update
    sudo apt-get install -y docker-ce-rootless-extras
    dockerd-rootless-setuptool.sh install

    echo "Menambahkan rootless Docker ke PATH Anda."
    echo "Tambahkan baris berikut ke file .bashrc Anda:"
    echo "export PATH=\$HOME/bin:\$PATH"
    echo "Lalu jalankan 'source ~/.bashrc'."

    echo "export PATH=\$HOME/bin:\$PATH" >> ~/.bashrc
    source ~/.bashrc

    echo "Selesaikan setup dengan menjalankan: docker info"
    echo "Rootless mode berhasil diatur!"

# Memeriksa dan menghapus container jika ada
echo "Memeriksa apakah container Docker dengan nama 'privanetix-node' ada..."

if docker ps -a --format '{{.Names}}' | grep -q 'privanetix-node'; then
    echo "Container 'privanetix-node' ditemukan. Menghentikan dan menghapus container..."
    docker stop privanetix-node
    docker rm privanetix-node
    echo "Container 'privanetix-node' telah dihapus."
else
    echo "Container 'privanetix-node' tidak ditemukan."
fi

# Menarik image Docker privasea/acceleration-node-beta:latest
echo "Menarik image Docker 'privasea/acceleration-node-beta:latest'..."
sudo docker pull privasea/acceleration-node-beta:latest

# Menunggu selama 20 detik
echo "Menunggu 20 detik..."
sleep 20

# Membuat direktori ~/privasea/config
echo "Membuat direktori ~/privasea/config..."
sudo mkdir -p ~/privasea/config

# Menunggu selama 3 detik
echo "Menunggu 3 detik..."
sleep 3

# Meminta input pengguna untuk wallet_keystore
echo "Masukkan isi untuk file 'wallet_keystore':"
read -p "Masukkan data wallet: " wallet_data

# Menulis data ke dalam file wallet_keystore
echo "$wallet_data" > ~/privasea/config/wallet_keystore
echo "File 'wallet_keystore' berhasil dibuat di ~/privasea/config."

# Meminta informasi keystore baru
echo "Masukkan informasi keystore baru..."
echo "Masukkan password untuk keystore: "
read -sp "Password: " KEYSTORE_PASSWORD

# Menunggu selama 3 detik
echo "Menunggu 3 detik..."
sleep 3

# Menjalankan container Privasea Privanetix Node
echo "Starting your Privasea Privanetix Node..."
sudo docker run -d --name privanetix-node -v "$HOME/privasea/config:/app/config" -e KEYSTORE_PASSWORD=$KEYSTORE_PASSWORD privasea/acceleration-node-beta:latest
sleep 5

# Merestart container setelah dijalankan
sudo docker restart privanetix-node
sleep 5

# Menampilkan log container
sudo docker logs privanetix-node
sleep 1

echo "Node setup is complete! Don't forget to Subscribe, like & share Youtube: SHARE IT HUB."
