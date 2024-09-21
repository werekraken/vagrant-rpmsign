#!/bin/bash

set -e

yum install -y \
  pinentry-tty \
  rpm-sign

rpm --import \
  /vagrant/RPM-GPG-KEY-*-public.asc
