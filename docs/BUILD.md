# Construção e testes

Host recomendado: Debian 13 amd64, 4 GB RAM, 20 GB livres e rede.

1. Rode `bash scripts/validate.sh`.
2. Rode `sudo bash scripts/build.sh --clean`.
3. Verifique os arquivos ISO, SHA-256 e os logs de build.
4. Teste boot em VM BIOS e UEFI, login, rede, áudio, Openbox e navegador.
5. Teste instalação em disco virtual descartável, reinício sem ISO e atualização de pacotes.
6. Não publique como estável sem executar os testes anteriores.

Exemplo para BIOS: `qemu-system-x86_64 -m 4096 -smp 2 -cdrom live-image-amd64.hybrid.iso -boot d`. Ajuste o nome da imagem gerada.
