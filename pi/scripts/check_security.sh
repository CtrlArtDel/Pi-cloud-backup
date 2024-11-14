#!/bin/bash
echo "Checking security configurations..."

if grep -q "PermitRootLogin no" /etc/ssh/sshd_config; then
    echo "Root login is disabled (Good)."
else
    echo "Warning: Root login is enabled. Please disable it."
fi

if grep -q "PasswordAuthentication no" /etc/ssh/sshd_config; then
    echo "Password authentication is disabled (Good)."
else
    echo "Warning: Password authentication is enabled. Please disable it."
fi

echo "Security checks completed."

