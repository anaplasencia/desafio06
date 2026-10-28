## Plan por etapas

| Etapa | Qué se hace | Responsable | Fecha | Evidencia |
| --- | --- | --- | --- | --- |
| 1. Base | VM Ubuntu Server con Docker Engine y Docker Compose | Ana | 28/10/2026 | Captura de docker --version |
| 2. Servicios | Nginx, web1, web2 y Portainer en Docker | Ana | 31/10/2026 | Captura de docker ps |
| 3. Seguridad | Firewall UFW (22, 80, 443) y claves SSH | Ana | 04/11/2026 | Captura de ufw status |
| 4. Monitoreo | cAdvisor, Prometheus, Grafana y Uptime Kuma | Ana | 07/11/2026 | Captura del panel de Grafana |
| 5. Respaldo | Respaldo diario con cron y prueba de restauración | Ana | 11/11/2026 | Captura del .tar.gz creado |
| 6. Pruebas y documentación | Prueba de cada servicio y README | Ana | 15/11/2026 | Captura de las pruebas |
