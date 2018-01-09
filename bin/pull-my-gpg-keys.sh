#!/bin/bash

# Pull and import my public keys from keybase.  It doesn't contain *all* of my
# keys, but should contain any current ones that I use.
curl https://keybase.io/justyns/pgp_keys.asc | gpg --import
