#!/bin/bash
source ../setup/secrets.conf

echo "Starting backup to Nextcloud..."
rsync -avz --delete "$SOURCE_DIR/" "$NEXTCLOUD_USER@$NEXTCLOUD_IP/remote.php/webdav/"
echo "Backup to Nextcloud completed successfully."

