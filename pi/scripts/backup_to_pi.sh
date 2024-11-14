#!/bin/bash
source ../setup/secrets.conf

echo "Starting backup to Raspberry Pi..."
rsync -avz --delete "$SOURCE_DIR/" "$PI_USER@$PI_IP:$PI_BACKUP_DIR/"
echo "Backup to Raspberry Pi completed successfully."

