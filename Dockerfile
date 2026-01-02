FROM debian:12.12-slim

LABEL maintainer="Christian Lempa"
LABEL description="Corosync QNetd server for Proxmox VE cluster quorum with SSH"
LABEL version="1.1"

# Install corosync-qnetd and SSH
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        corosync-qnetd \
        openssh-server \
        netcat-openbsd \
        procps && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Configure SSH
RUN mkdir -p /var/run/sshd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Set default root password (CHANGE THIS!)
RUN echo 'root:proxmox' | chpasswd

# Expose ports
EXPOSE 5403 22

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD nc -z localhost 5403 && nc -z localhost 22 || exit 1

# Entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
