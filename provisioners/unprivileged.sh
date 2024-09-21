#!/bin/bash

set -e

# Create `~/.gnupg/` and default files.
gpg --list-keys >/dev/null 2>&1

# Set allow-preset-passphrase.
cp /vagrant/gpg-agent.conf ~/.gnupg/

# Reload the agent to update in-memory config.
gpg-connect-agent reloadagent /bye

passphrase="$(
  cat /vagrant/RPM-GPG-KEY-*-passphrase
)"

# Import the private key.
gpg --import --batch \
  --passphrase "$passphrase" \
  /vagrant/RPM-GPG-KEY-*-private.asc
