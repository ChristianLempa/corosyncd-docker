# Corosync QNetd Docker Container

Docker container for running Corosync QNetd server, used as a quorum device for Proxmox VE clusters.

## What is QNetd?

Corosync QNetd (Quorum Network Daemon) provides an external vote for cluster quorum calculations. It's particularly useful for:
- 2-node Proxmox VE clusters
- Even-numbered clusters (2, 4, 6 nodes)
- Preventing split-brain scenarios

## Quick Start

### Using Docker Compose (Recommended)

```bash
# Clone the repository
git clone https://github.com/christianlempa/corosyncd-docker.git
cd corosyncd-docker

# Start the container
docker-compose up -d

# Check logs
docker-compose logs -f
