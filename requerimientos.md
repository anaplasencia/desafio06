# Requerimientos del proyecto

| ID | Tipo | Requerimiento | Cómo se comprueba |
|---|---|---|---|
| RF1 | Funcional | Publicar un sitio web institucional. | El sitio abre en el navegador por HTTP/HTTPS. |
| RF2 | Funcional | Respaldar los datos cada noche. | Aparece un archivo nuevo en backups/ cada día. |
| RF3 | Funcional | Mostrar métricas de los servicios en un panel. | Grafana muestra el estado de Nginx, la aplicación y la base de datos. |
| RNF1 | Disponibilidad | Disponibilidad >= 99 % en horario académico. | Registro de disponibilidad en Grafana. |
| RNF2 | Seguridad | Solo puertos 22, 80 y 443 abiertos. | El estado de UFW lista solo esos puertos. |
| RNF3 | Seguridad | Acceso por SSH solo con claves. | El acceso con contraseña es rechazado. |
| RNF4 | Monitoreo | Alertas ante la caída de un servicio. | Al detener un contenedor llega una alerta. |
