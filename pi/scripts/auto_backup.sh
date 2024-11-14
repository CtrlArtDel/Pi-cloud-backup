#!/bin/bash
# This script is part of the main setup_pi.sh script to schedule auto-backup using cron.

# Schedule backup
schedule_auto_backup() {
    echo "Setting up auto-backup schedule using cron..."
    
    echo "Please choose your schedule frequency:"
    echo "1. Daily"
    echo "2. Weekly"
    echo "3. Custom (Enter your cron schedule)"
    read -p "Enter your choice (1/2/3): " choice

    case $choice in
        1)
            cron_time="0 0 * * *"
            ;;
        2)
            cron_time="0 0 * * 0"
            ;;
        3)
            read -p "Enter your custom cron schedule (e.g., '0 0 * * *' for daily at midnight): " cron_time
            ;;
        *)
            echo "Invalid choice. Exiting."
            return
            ;;
    esac

    # Choose backup option
    echo "Choose which backup to schedule:"
    echo "1. Single Backup to Raspberry Pi"
    echo "2. Single Backup to Nextcloud"
    echo "3. Double Backup (Pi + Nextcloud)"
    read -p "Enter your choice (1/2/3): " backup_option

    case $backup_option in
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
            echo "Invalid choice. Exiting."
            return
            ;;
    esac

    (crontab -l ; echo "$cron_time $cron_cmd >> /var/log/auto_backup.log 2>&1") | crontab -
    echo "Auto-backup scheduled successfully."
}

