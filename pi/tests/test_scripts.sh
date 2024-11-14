#!/bin/bash
echo "Testing backup to Raspberry Pi..."
../scripts/backup_to_pi.sh --dry-run

echo "Testing backup to Nextcloud..."
../scripts/backup_to_nextcloud.sh --dry-run

echo "Testing double backup..."
../scripts/double_backup.sh --dry-run

echo "Testing completed."

