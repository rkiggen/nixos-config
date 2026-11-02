# Basic hardening
noroot
nonewprivs
caps.drop all
seccomp
private-tmp
private-cache

# Hide sensitive credentials
blacklist ${HOME}/.ssh
blacklist ${HOME}/.aws
blacklist ${HOME}/.azure
blacklist ${HOME}/.kube

# Prevent Docker socket access
blacklist /run/docker.sock
blacklist /var/run/docker.sock