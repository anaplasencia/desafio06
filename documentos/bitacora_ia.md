# Bitacora de uso de IA - Desafio 6

**Alumna:** Plasencia Silva, Ana Evila

| # | Que le pedi a la IA | Que me respondio | Como lo verifique | Mi decision |
|---|---|---|---|---|
| 1 | Simular perdida y recuperacion de informacion | Scripts con borrado real y restauracion con tar | Ejecute los comandos y revise que los archivos volvieron | Usar la demo manual como prueba principal |
| 2 | Verificar integridad | sha256sum -c con archivo de hashes | Comprobe que ambos archivos dieron OK | Incluirlo en el procedimiento |
| 3 | Generar catalogo de backups | Script catalogar.sh | Lo ejecute y revise fecha, tamano y hash
| 4 | Subir el trabajo a GitHub | Comandos git, pull --rebase y push | Confirme los archivos en GitHub | Dejar lab_perdida fuera del repositorio |

## Lo que aprendi
- El RTO es el tiempo que tardo en recuperar los datos y el RPO es cuántos datos puedo perder desde el último backup.
- Se usa SHA256 para comprobar que un archivo no cambió ni se dañó.
- La regla 3-2-1 es tener 3 copias, en 2 tipos de medio distintos y 1 copia fuera del servidor.

## Errores que encontre y como los resolvi
- El git push fue rechazado porque GitHub tenia cambios nuevos. Lo resolvi con git stash y git pull --rebase.
