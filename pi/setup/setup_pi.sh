#!/bin/bash
# Load secrets and configuration from the external file
source secrets.conf

# Function to configure Wi-Fi Hotspot
configure_wifi() {
    echo "Configuring Wi-Fi Hotspot..."
    ./setup_wifi.sh
}

# Function to configure LAN Connection
configure_lan() {
    echo "Configuring LAN..."
    ./setup_lan.sh
}

# Function to install Nextcloud
install_nextcloud() {
    echo "Installing Nextcloud..."
    ./install_nextcloud.sh
}

# Function to schedule automatic backups
schedule_auto_backup() {
    echo "Setting up auto-backup schedule using cron..."
    
    # Backup frequency selection
    echo "How often would you like to schedule automatic backups?"
    echo "1. Daily at midnight"
    echo "2. Every week at midnight"
    echo "3. Custom (you will enter a cron schedule)"
    read -p "Enter your choice (1/2/3): " schedule_choice
    
    case $schedule_choice in
        1)
            cron_time="0 0 * * *"
            ;;
        2)
            cron_time="0 0 * * 0"
            ;;
        3)
            read -p "Enter your cron schedule (e.g., '0 0 * * *' for daily at midnight): " cron_time
            ;;
        *)
            echo "Invalid choice. Exiting auto-backup setup."
            return
            ;;
    esac

    # Choose backup type
    echo "Which backup do you want to schedule automatically?"
    echo "1. Single Backup to Raspberry Pi"
    echo "2. Single Backup to Nextcloud"
    echo "3. Double Backup to Raspberry Pi and Nextcloud"
    read -p "Enter your choice (1, 2, or 3): " backup_choice

    case $backup_choice in
        1)
            cron_cmd="./scripts/backup_to_pi.sh"
            ;;
        2)
            cron_cmd="./scripts/backup_to_nextcloud.sh"
            ;;
        3)
            cron_cmd="./scripts/double_backup.sh"
            ;;
        *)
            echo "Invalid choice. Exiting auto-backup setup."
            return
            ;;
    esac

    (crontab -l ; echo "$cron_time $cron_cmd >> /var/log/auto_backup.log 2>&1") | crontab -
    echo "Auto-backup scheduled with cron."
}

# Select network configuration
echo "Please choose your network setup:"
echo "1. Wi-Fi Hotspot (Direct connection)"
echo "2. LAN Connection (Same Network)"
read -p "Enter your choice (1 or 2): " network_choice

if [ "$network_choice" -eq 1 ]; then
    configure_wifi
elif [ "$network_choice" -eq 2 ]; then
    configure_lan
else
    echo "Invalid choice. Exiting setup."
    exit 1
fi

# Install Nextcloud if needed
read -p "Do you want to install Nextcloud? (yes/no): " install_nc
if [ "$install_nc" == "yes" ]; then
    install_nextcloud
fi

# Schedule automatic backups
read -p "Do you want to schedule automatic backups? (yes/no): " schedule_auto
if [ "$schedule_auto" == "yes" ]; then
    schedule_auto_backup
fi

echo "Setup complete!"

