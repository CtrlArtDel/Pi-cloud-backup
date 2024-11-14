#!/bin/bash
source ../setup/secrets.conf

echo "Starting backup to Raspberry Pi from computer..."
rsync -avz --delete "$SOURCE_DIR/" "$PI_USER@$PI_IP:/path/to/pi/backup"
echo "Backup to Raspberry Pi completed successfully."

