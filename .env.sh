#!/bin/bash

set -e

export HCLOUD_TOKEN="REPLACE_ME"
export POLKADOT_USER_PASSWORD="REPLACE_ME"
#eval "$(op signin)"
#export HCLOUD_TOKEN=$(op item list --vault polkadot | op item get 'hcloud' --fields token --reveal)
#export POLKADOT_USER_PASSWORD=$(op item list --vault polkadot | op item get 'user' --fields password --reveal)
export TF_VAR_polkadot_user_password=python3 -c 'import bcrypt; print(bcrypt.hashpw(b"$POLKADOT_USER_PASSWORD", bcrypt.gensalt()).decode())'

