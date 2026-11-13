#!/usr/bin/env bash
set -Eeuo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"
if [[ "${1:-}" == "--help" ]]; then echo 'Uso: sudo bash scripts/build.sh [--clean]'; exit 0; fi
if [[ $# -gt 1 || ( $# -eq 1 && "$1" != "--clean" ) ]]; then echo 'Argumento inválido' >&2; exit 2; fi
if [[ "$EUID" != 0 ]]; then echo 'Requer root' >&2; exit 1; fi
if [[ "$(dpkg --print-architecture)" != "amd64" ]]; then echo 'Host requer amd64' >&2; exit 1; fi
for cmd in lb debootstrap mksquashfs xorriso tee sha256sum; do command -v "$cmd" >/dev/null || { echo "Falta $cmd" >&2; exit 1; }; done
mkdir -p out/logs
LOG="out/logs/build-$(date -u +%Y%m%dT%H%M%SZ).log"
exec > >(tee -a "$LOG") 2>&1
trap 's=$?; echo "ERRO $s, linha $LINENO - log $LOG" >&2' ERR
bash scripts/validate.sh
if [[ "${1:-}" == "--clean" ]]; then lb clean --purge; fi
mkdir -p .build
: > .build/config
lb build
shopt -s nullglob
images=(live-image-*.hybrid.iso)
if (( ${#images[@]} != 1 )); then echo 'ISO não encontrada ou saída ambígua' >&2; exit 1; fi
sha256sum "${images[0]}" | tee "${images[0]}.sha256"
echo "ISO criada: ${images[0]}"
