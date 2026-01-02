FROM debian:12.12-slim

LABEL maintainer="Christian Lempa"
LABEL description="Corosync QNetd server for Proxmox VE cluster quorum"
LABEL version="1.0"

# Install corosync-qnetd
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        corosync-qnetd \
        netcat-openbsd \
        procps && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create necessary directories
RUN mkdir -p /etc/corosync/qnetd/nssdb

# Initialize the certificate database
RUN corosync-qnetd-certutil -i

# Expose the QNetd port
EXPOSE 5403

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD nc -z localhost 5403 || exit 1

# Run corosync-qnetd in foreground with debug output
CMD ["corosync-qnetd", "-f", "-d"]
