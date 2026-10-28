# Requerimientos del proyecto

## Funcionales
RF1: Publicar el sitio web por HAProxy (puerto 80), repartiendo entre web1 y web2.
RF2: Guardar los datos en MySQL (db).
RF3: Respaldar la base de datos cada noche con respaldo.sh.

## No funcionales
RNF1: Disponibilidad >= 99 % en horario academico.
RNF2: Alerta ante la caida de un servicio en menos de 1 minuto.
RNF3: El sitio responde con codigo 200 en menos de 2 segundos.
