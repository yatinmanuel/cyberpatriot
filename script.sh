#!/bin/bash

# Check if the script is running as root, if not, ask for root privileges.
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root using sudo."
    exit 1
fi

# Update and upgrade the system.
sudo apt update
sudo apt upgrade -y

# Remove unnecessary apps.
sudo apt remove wireshark -y
sudo apt remove ophcrack -y
sudo apt autoremove -y

# Enable the firewall.
sudo ufw enable

# Stop and disable nginx.
sudo systemctl stop nginx
sudo systemctl disable nginx

# Disable root login for SSH.
sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sudo systemctl restart ssh

# Modify user accounts.
sudo userdel balloony
sudo gpasswd -d doofenshmirtz sudo
sudo gpasswd -d lawrence sudo
sudo gpasswd -a candace firesidegirls

# Change the password for the user "pinky."
echo "Changing password for user pinky..."
echo "pinky:ch4ng3M@3" | sudo chpasswd

# Delete files in the /home/linda/Music/ directory.
rm -rf /home/linda/Music/*

# Answer Forensics Question 1.
forensics_question_1="/home/perry/Desktop/Forensics Question 1.txt"
if [ -f "$forensics_question_1" ]; then
    sed -i 's/<Type Answer Here>/affidavit/g' "$forensics_question_1"
    echo "Answered Forensics Question 1."
fi

# Answer Forensics Question 2.
forensics_question_2="/home/perry/Desktop/Forensics Question 2.txt"
if [ -f "$forensics_question_2" ]; then
    sed -i 's/<Type Answer Here>/\/home\/linda\/Music/g' "$forensics_question_2"
    echo "Answered Forensics Question 2."
fi

# Enable automatic updates in 20auto-upgrades.
auto_upgrades_config="/etc/apt/apt.conf.d/20auto-upgrades"
if [ -f "$auto_upgrades_config" ]; then
    # Change options to enable automatic updates and checking.
    sed -i 's/0/1/g' "$auto_upgrades_config"
    echo "Enabled automatic updates in $auto_upgrades_config."
fi

# Notify completion.
echo "Script execution completed."
