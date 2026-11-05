# Desafio 6: Automatizacion de Backup Multinivel

**Alumna:** Plasencia Silva, Ana Evila
**Curso:** Administracion de Plataformas de TI - IESTP Paijan

## Objetivo
Estrategia de backup 3-2-1 (local, USB externo, red NAS) con verificacion SHA256, catalogo y restauracion bajo pruebas controladas.

## Scripts (carpeta `scripts/`)
| Script | Funcion |
|---|---|
| `backup.sh` | Crea el backup incremental y lo copia a local, USB y NAS |
| `verificacion.sh` | Verifica la integridad con SHA256 |
| `restore.sh` | Restaura los datos desde el backup |
| `catalogar.sh` | Genera el catalogo de backups en `documentos/catalogo_backups.md` |
| `perdida.sh` / `recuperacion.sh` | Demostracion de perdida y recuperacion real |

## Uso
```bash
./scripts/backup.sh
./scripts/verificacion.sh
./scripts/restore.sh
./scripts/catalogar.sh
```

## Procedimiento de prueba (perdida y recuperacion)
1. Crear datos y generar el backup con su hash SHA256.
2. Simular la perdida borrando los datos (`rm -rf`).
3. Restaurar con `tar -xzf` y medir el tiempo con `time` (RTO).
4. Verificar con `sha256sum -c` que los datos son identicos.

## Metricas
- **RTO** (tiempo de recuperacion): medido con `time` en la restauracion.
- **RPO** (perdida aceptable): tiempo entre el ultimo backup y la falla.

## Documentacion
- `documentos/catalogo_backups.md`: catalogo de backups
- `documentos/arquitectura.md`: arquitectura
- `plan.md`, `requerimientos.md`, `riesgos.txt`
