#!/bin/bash
set -euo pipefail

if [[ ! -f "${HOME}/.ssh/signing_ed25519" ]]; then
  "${HOME}/bin/signing-key-sync"
fi
