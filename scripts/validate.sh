#!/usr/bin/env bash
set -Eeuo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"
fail=0
for file in README.md config/bootstrap config/chroot config/binary config/package-lists/live.list.chroot config/includes.chroot/etc/os-release scripts/build.sh; do
 if [[ ! -s "$file" ]]; then printf 'ERRO: ausente %s\n' "$file" >&2; fail=1; fi
done
for file in scripts/*.sh; do bash -n "$file" || fail=1; done
if grep -Eq '^LB_LINUX_PACKAGES="linux-image-[0-9]' config/chroot; then echo 'ERRO: kernel fixado' >&2; fail=1; fi
if grep -qx cbpp-metapackage config/package-lists/live.list.chroot; then echo 'ERRO: metapacote legado' >&2; fail=1; fi
for file in config/archives/cbpp.list.chroot config/archives/cbpp.list.binary config/hooks/live/0990-sources-fix.hook.chroot config/hooks/normal/0990-sources-fix.hook.chroot; do
 if [[ -e "$file" ]]; then printf 'ERRO: legado %s\n' "$file" >&2; fail=1; fi
done
if [[ "$fail" != 0 ]]; then exit 1; fi
echo 'Validação estática aprovada. Build e boot não foram testados.'
