# OklaOS

**OklaOS** é uma distribuição GNU/Linux leve da **Oklaworks®**, derivada da configuração do CrunchBang++ e baseada no Debian 13 (Trixie).

**Status: base de desenvolvimento. A ISO ainda exige construção e testes de inicialização em máquina virtual.**

## Construção

Em Debian 13 amd64, instale: `sudo apt update && sudo apt install -y live-build debootstrap squashfs-tools xorriso isolinux syslinux-utils dosfstools grub-pc-bin grub-efi-amd64-bin ca-certificates`.

Execute `bash scripts/validate.sh` e depois `sudo bash scripts/build.sh`. Para reiniciar o build do zero, use `sudo bash scripts/build.sh --clean`.

A saída, quando concluída, será uma imagem ISO híbrida e um arquivo SHA-256. Confira `docs/BUILD.md` e `docs/UPSTREAM.md`.

Identidade de produto: **OklaOS**. Base: **Debian 13**. Interface: **Openbox + tint2 + LightDM**. Licenças e créditos upstream são preservados.
