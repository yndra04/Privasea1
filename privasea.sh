#!/bin/bash

# Menampilkan teks ASCII dengan pesan
echo "   ______ _____   ___  ____  __________  __ ____  _____ "
echo "  / __/ // / _ | / _ \/ __/ /  _/_  __/ / // / / / / _ )"
echo " _\ \/ _  / __ |/ , _/ _/  _/ /  / /   / _  / /_/ / _  |"
echo "/___/_//_/_/ |_/_/|_/___/ /___/ /_/   /_//_/\____/____/ "
echo "               SUBSCRIBE MY CHANNEL                     "
sleep 2  # Delay 2 detik

rm -fr privasea
sleep 3
# Meminta input dari pengguna untuk KEYSTORE_PASSWORD
echo "Masukkan KEYSTORE_PASSWORD Anda:"
read -s KEYSTORE_PASSWORD  # -s untuk menyembunyikan input password

# Menarik Docker image privasea/acceleration-node-beta:latest menggunakan sudo
echo "Pulling Docker image privasea/acceleration-node-beta:latest..."
sudo docker pull privasea/acceleration-node-beta:latest
sleep 3  # Delay 3 detik

# Membuat direktori dan berpindah ke dalam direktori tersebut
echo "Creating ~/privasea/config directory..."
sudo mkdir -p ~/privasea/config && cd ~/privasea
sleep 2  # Delay 2 detik

# Meminta input dari pengguna untuk isi file wallet_keystore
echo "Masukkan isi wallet_keystore Anda:"
read wallet_keystore_content

# Membuat file wallet_keystore dan menulis isi yang dimasukkan oleh pengguna
echo "$wallet_keystore_content" | sudo tee ~/privasea/config/wallet_keystore > /dev/null
sleep 2  # Delay 2 detik

# Menjalankan Docker container dengan KEYSTORE_PASSWORD yang dimasukkan
echo "Menjalankan Docker container privanetix-node dengan KEYSTORE_PASSWORD..."
sudo docker run -d --name privanetix-node -v "$HOME/privasea/config:/app/config" -e KEYSTORE_PASSWORD=$KEYSTORE_PASSWORD privasea/acceleration-node-beta:latest
sleep 3  # Delay 3 detik

# Merestart Docker container privanetix-node
echo "Merestart Docker container privanetix-node..."
sudo docker restart privanetix-node
sleep 3  # Delay 3 detik

# Menampilkan log dari Docker container privanetix-node
echo "Menampilkan log dari Docker container privanetix-node..."
sudo docker logs privanetix-node
sleep 3  # Delay 3 detik

echo "Semua operasi telah selesai."
