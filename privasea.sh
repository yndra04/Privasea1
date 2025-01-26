#!/bin/bash
echo "   ______ _____   ___  ____  __________  __ ____  _____ "
echo "  / __/ // / _ | / _ \/ __/ /  _/_  __/ / // / / / / _ )"
echo " _\ \/ _  / __ |/ , _/ _/  _/ /  / /   / _  / /_/ / _  |"
echo "/___/_//_/_/ |_/_/|_/___/ /___/ /_/   /_//_/\____/____/ "
echo "               - PRIVASEA NODE -                        "
sleep 3

# Meminta input dari pengguna sebelum proses pengaturan dimulai
echo "Membuat folder privasea/config..."
sudo mkdir -p ~/privasea/config
echo "Folder privasea/config berhasil dibuat."

echo "Masukkan informasi keystore baru..."
echo "Masukkan password untuk keystore: "
read -sp "Password: " KEYSTORE_PASSWORD
echo

if [ -z "$KEYSTORE_PASSWORD" ]; then
    echo "Error: Password tidak boleh kosong!"
    exit 1
fi

echo "Masukkan isi untuk wallet_keystore.json (sebagai JSON):"
echo "Contoh format: {\"address\": \"your-address\", \"key\": \"your-key\"}"
echo "Masukkan informasi keystore:"
read -p "Masukkan JSON: " KEYS_CONTENT
echo

if [ -z "$KEYS_CONTENT" ]; then
    echo "Error: JSON keystore tidak boleh kosong!"
    exit 1
fi

# Menyimpan JSON ke dalam file keystore di direktori ~/privasea/config
echo "$KEYS_CONTENT" > ~/privasea/config/wallet_keystore
echo "Keystore berhasil dibuat dan disimpan di ~/privasea/config/wallet_keystore"

# Menyimpan password keystore di direktori ~/privasea/config
echo "$KEYSTORE_PASSWORD" > ~/privasea/config/keystore_password.txt
echo "Password untuk keystore berhasil disimpan di ~/privasea/config/keystore_password.txt"

# Sekarang, kita lanjutkan ke pengaturan Docker dan Privasea

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

echo "Melanjutkan ke pengaturan Privasea Privanetix Node..."

echo "Installing Docker..."
sudo bash -c "source <(wget -O - https://raw.githubusercontent.com/shareithub/Privasea/refs/heads/main/docker.sh)"

echo "Pulling Privasea Docker image..."
sudo docker pull privasea/acceleration-node-beta:latest
echo "Waiting for 20 seconds to ensure the image is pulled properly..."
sleep 20

echo "Starting your Privasea Privanetix Node..."
sudo docker run -d --name privanetix-node -v "$HOME/privasea/config:/app/config" -e KEYSTORE_PASSWORD=$KEYSTORE_PASSWORD privasea/acceleration-node-beta:latest
sleep 5

sudo docker restart privanetix-node
sleep 5

sudo docker logs privanetix-node
sleep 1
echo "Node setup is complete! Your Privanetix Node is running."
