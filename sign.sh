#!/bin/bash

set -e

passphrase="$(
  cat /vagrant/RPM-GPG-KEY-*-passphrase
)"

gpg --with-keygrip --show-keys /vagrant/RPM-GPG-KEY-*-private.asc \
  | fgrep -B1 'Keygrip = ' \
  | awk '{print $NF}' \
  | {
      read keyid
      read keygrip

      # Use the keygrip to preset the passphrase.
      /usr/libexec/gpg-preset-passphrase \
        --passphrase "$passphrase" \
        --preset "$keygrip"

      # Sign the rpms.
      rpmsign --addsign --key-id "$keyid" "$@"

      # Validate signatures.
      rpm -K "$@"
    }
