#!/bin/bash
source secrets.conf

echo "Installing Nextcloud dependencies..."
sudo apt-get update
sudo apt-get install -y apache2 mariadb-server libapache2-mod-php php-mysql \
    php-gd php-json php-curl php-zip php-xml php-mbstring

echo "Downloading and installing Nextcloud..."
wget https://download.nextcloud.com/server/releases/latest.tar.bz2
sudo tar -xjf latest.tar.bz2 -C /var/www/html/
sudo chown -R www-data:www-data /var/www/html/nextcloud/

echo "Configuring Nextcloud..."
sudo -u www-data php /var/www/html/nextcloud/occ maintenance:install \
    --database "mysql" --database-name "$DB_NAME" --database-user "$DB_USER" \
    --database-pass "$DB_PASS" --admin-user "$ADMIN_USER" --admin-pass "$ADMIN_PASS"

echo "Nextcloud installation complete."

