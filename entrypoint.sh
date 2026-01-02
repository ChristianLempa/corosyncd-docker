#!/bin/bash
set -e

echo "Starting SSH daemon..."
/usr/sbin/sshd

echo "Starting corosync-qnetd..."
exec corosync-qnetd -f -d
