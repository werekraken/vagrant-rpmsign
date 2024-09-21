#!/bin/bash

set -e

ls *.rpm >/dev/null 2>&1

rpmdir="$(
  realpath .
)"

cd "$(
  dirname "$(
    realpath -- "${BASH_SOURCE[0]}"
  )"
)"

vagrant up

vagrant ssh -c 'rm -rf SIGNROOT || true'

# Copy in.
rsync -ave 'vagrant ssh --' "$rpmdir"/*.rpm :SIGNROOT/

vagrant ssh -c 'cd SIGNROOT && bash /vagrant/sign.sh *.rpm'

# Copy out.
rsync -ave 'vagrant ssh --' :SIGNROOT/* "$rpmdir"/signed/
