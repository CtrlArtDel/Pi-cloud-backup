# PiCloud Backup Solution

## Overview

The **PiCloud Backup Solution** provides an easy and secure way to back up your data to a Raspberry Pi and/or a Nextcloud instance. It supports two types of connections: **Wi-Fi Hotspot** (direct connection) or **LAN** (same network). You can choose between backing up to the Raspberry Pi, Nextcloud, or both, and you can also schedule automatic backups with customizable frequencies.

## Chapter 1: Raspberry Pi (Server-Side)

### 1.1 Installation on Raspberry Pi

This section covers setting up the **Raspberry Pi** as the backup server.

Prerequisites:
- A **Raspberry Pi** running a Linux-based OS.
- SSH access to the Raspberry Pi.
- Ensure the Pi has a stable internet connection for downloading dependencies.


**Step-by-Step Guide**:

 1. **Clone the Repository**: Open a terminal on the Raspberry Pi or SSH into it, then clone the project repository:

```bash
git clone https://github.com/your-repo/pi-cloud-backup.git
cd pi-cloud-backup/pi/setup
```

2. **Make Setup Scripts Executable**: Ensure the setup scripts are executable:

```bash
chmod +x *.sh
```

3. **Run the Main Setup Script**: Execute the main setup script that will guide you through the process of configuring network settings and backups:

```bash
sudo ./setup_pi.sh
```

4. **Select Network Configuration**: You will be prompted to choose between two network configurations:

- **Wi-Fi Hotspot (Direct Connection)**: Select this option if you want your Raspberry Pi to act as a Wi-Fi hotspot that your backup computer will connect to.
 
- **LAN Connection (Same Network)**: Choose this option if both your Raspberry Pi and backup computer are on the same local network.
After selecting the network type, the script will automatically configure your Raspberry Pi based on your choice.

5. **Install Nextcloud (Optional)**: If you want to use **Nextcloud** as a backup destination, choose "yes" when prompted to install and configure Nextcloud.

6. **Schedule Automatic Backups (Optional)**: After setting up the network, you will be prompted to schedule automatic backups using cron:

- You can choose between **daily**, **weekly**, or **custom** frequencies.
- You can select to back up to Raspberry Pi, Nextcloud, or both. The cron jobs will log the backup process in `/var/log/auto_backup.log`.
7. **Complete Setup**: Once the setup process is complete, your Raspberry Pi will be ready to act as a backup server.

### 1.2 Backup Options for Raspberry Pi
You can choose between the following backup options:

- **Backup to Raspberry Pi**: This backs up data from your backup computer to a folder on the Raspberry Pi.

```bash
./scripts/backup_to_pi.sh
```

- **Backup to Nextcloud**: This backs up data from your backup computer to Nextcloud using WebDAV.

```bash
./scripts/backup_to_nextcloud.sh
```

- **Double Backup**: This backs up data to both the Raspberry Pi and Nextcloud.

```bash
./scripts/double_backup.sh
```

### 1.3 Auto-Backup Scheduling on Raspberry Pi
If you chose to set up automatic backups during the Raspberry Pi setup, the backups will automatically occur at the scheduled time. You can view the cron job logs here:

```bash
/var/log/auto_backup.log
```

If you need to update or delete the auto-backup schedule, you can modify the cron jobs:

```bash
crontab -e
```

### 1.4 Security Configuration for Raspberry Pi
Ensure your Raspberry Pi is configured securely:

1. **Disable Root Login**: Verify that root login over SSH is disabled for security purposes. Edit the SSH configuration:

```bash
sudo nano /etc/ssh/sshd_config
```

Ensure the following lines are present:

```bash
PermitRootLogin no
PasswordAuthentication no
```

2. **Run the Security Checker Script**: You can use the provided `check_security.sh` script to check basic security settings on your Raspberry Pi.

```bash
./scripts/check_security.sh
```

### 1.5 Testing Backup Functionality on Raspberry Pi
It is recommended to test the backup scripts before fully relying on them. Use the provided test script:

```bash
cd pi-cloud-backup/pi/tests
./test_scripts.sh
```

## Chapter 2: Backup Computer (Client-Side)

### 2.1 Installation on Backup Computer

This section covers setting up the computer that will be used to back up data to the Raspberry Pi.

**Prerequisites**:
- A Linux-based computer (or any OS that supports `rsync` and SSH).
- SSH access to the Raspberry Pi.
- Ensure the computer is either connected to the Raspberry Pi’s Wi-Fi Hotspot or is on the same network as the Pi.
**Step-by-Step Guide**:
1. **Clone the Repository**: On the backup computer, clone the repository:

```bash
git clone https://github.com/your-repo/pi-cloud-backup.git
cd pi-cloud-backup/computer/setup
```

2. **Configure Secrets**: Edit the secrets.conf file on the backup computer and update it with your Raspberry Pi credentials and paths:

```bash
nano secrets.conf
```

Example configuration:

```bash
PI_USER="pi"
PI_IP="192.168.1.100"
NEXTCLOUD_USER="nextcloud_user"
NEXTCLOUD_IP="192.168.1.101"
SOURCE_DIR="/path/to/local/backup"
```

3. **Make Scripts Executable** : Ensure all the scripts are executable:

```bash
chmod +x ../scripts/*.sh
```

4. **Run Backup Manually (Optional)**:

- **Backup to Raspberry Pi**:

```bash
../scripts/backup_to_pi.sh
```

- **Backup to Nextcloud**:

```bash
../scripts/backup_to_nextcloud.sh
```

- **Double Backup (Raspberry Pi + Nextcloud)**:

```bash
../scripts/double_backup.sh
```

5. **Automatic Backups (Optional)**: If you set up automatic backups on the Raspberry Pi during the setup process, no further action is needed on the computer side. Backups will run automatically according to the schedule you set.

### 2.2 Backup Options for the Computer
You can choose between the following backup options:

- **Backup to Raspberry Pi**: This backs up data from your computer to a folder on the Raspberry Pi.

```bash
./scripts/backup_to_pi.sh
```


- **Backup to Nextcloud**: This backs up data from your computer to Nextcloud using WebDAV.

```bash
./scripts/backup_to_nextcloud.sh
```

- **Double Backup**: This backs up data to both the Raspberry Pi and Nextcloud.

```bash
./scripts/double_backup.sh
```

### 2.3 Testing Backup Functionality on Backup Computer
It is recommended to test the backup scripts before fully relying on them. Use the provided test script:

```bash
cd pi-cloud-backup/computer/tests
./test_scripts.sh
```

### 2.4 Troubleshooting
If you run into issues on the backup computer or Raspberry Pi, follow these steps:

- **Check Logs**: If something goes wrong, check the log files for the automatic backups:

```bash
/var/log/auto_backup.log
```

- **Network Issues**: Ensure your Raspberry Pi and backup computer are either on the same network or connected via the Wi-Fi Hotspot. Test connectivity using ping or ssh:

```bash
ping 192.168.1.100   # Replace with the IP address of your Raspberry Pi
```

- **Permissions**: If any scripts fail to execute, make sure they have execute permissions:

```bash
chmod +x /path/to/script.sh
```



### Final Notes
The **PiCloud Backup Solution** provides a flexible and user-friendly way to back up data, offering multiple connection and backup options. You can also schedule automatic backups for seamless data protection.

If you run into issues or need assistance, feel free to check the logs or run the test scripts.

