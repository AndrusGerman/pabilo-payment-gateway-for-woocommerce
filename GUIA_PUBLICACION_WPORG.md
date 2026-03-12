# Guía de Publicación y Mantenimiento del Plugin en WordPress.org

Este documento recopila las directrices oficiales y mejores prácticas de WordPress.org para mantener, actualizar y gestionar los recursos gráficos (iconos, banners, capturas) de **Pabilo Payment Gateway for WooCommerce**.

---

## 1. Estructura del Repositorio SVN

WordPress.org utiliza Subversion (SVN) como sistema de control de versiones para los lanzamientos, no para el desarrollo del día a día. El repositorio de tu plugin tiene 3 carpetas principales:

- `/trunk`: Aquí debe vivir siempre el código principal y más reciente del plugin. Es la base de todo. Aunque uses Git (como GitHub/GitLab) para el desarrollo diario, debes mantener la carpeta `trunk` actualizada con tu código final de cada versión.
- `/tags`: Aquí se guardan las "versiones" publicadas del plugin (ej. `/tags/1.0.0`, `/tags/1.1.0`). Es crucial usar versionado semántico. El actualizador automático de WordPress se basa en estas carpetas.
- `/assets`: Aquí se guardan **todos los recursos gráficos** (iconos, banners, capturas de pantalla). **NO** deben ir ni en `trunk` ni en `tags`. Van en la raíz. Las imágenes servidas desde aquí utilizan CDN, por lo que los cambios pueden tardar desde unos minutos hasta 6 horas en reflejarse.

> **Nota:** La carpeta `/branches` está obsoleta y el sistema de WordPress.org no la utiliza. Se puede ignorar.

---

## 2. Mejores Prácticas de SVN y Actualizaciones

- **No uses SVN para desarrollo activo:** A diferencia de Git, SVN en WordPress.org es un sistema de *lanzamiento*. Si haces commits constantes por cada pequeño cambio, el sistema reconstruirá los archivos ZIP de tu plugin repetidamente, retrasando la aparición de nuevas versiones hasta por 6 horas. Sube (push) tu código solo cuando la nueva versión esté completamente lista.
- **Proceso correcto para lanzar una actualización:**
  1. Actualiza los archivos y el `readme.txt` en la carpeta `/trunk` indicando la nueva versión (ej. `Stable tag: 1.0.1`).
  2. Copia el contenido de `/trunk` a una nueva carpeta en `/tags` usando el comando SVN copy (ej. `svn cp /trunk /tags/1.0.1` o hazlo desde tu cliente SVN). 
  3. Haz el commit (push) de todos los cambios (trunk + nuevo tag) **en un solo paso**. Esto preserva el historial, mantiene los commits pequeños (SVN solo actualiza lo modificado) y reduce errores.
- **Nunca envíes código directamente a la carpeta del Tag:** Siempre debe pasar por `/trunk` primero y luego copiarse a `/tags/Version`.

---

## 3. Gestión de Recursos Gráficos (Assets / Iconos)

Todos los gráficos deben subirse a la carpeta raíz `/assets/`. **Requisitos de peso:** Banners máx. 4MB, Iconos máx. 1MB, Capturas máx. 10MB. Es mejor si están optimizadas para la web para ocupar menos.

### Iconos del Plugin
Aparecen en la búsqueda de WordPress.org y en el administrador de WordPress de los usuarios.
- **Normal:** `icon-128x128.png` (o `.jpg` / `.gif`)
- **Alta Definición (Retina):** `icon-256x256.png`
- **SVG:** `icon.svg` *(Si usas SVG, es **obligatorio** incluir un PNG de respaldo como `icon-256x256.png` para navegadores antiguos y previsualizaciones en redes sociales).*

### Banners (Cabeceras)
Son las imágenes que aparecen en la parte superior de la página de tu plugin en WordPress.org.
- **Normal:** `banner-772x250.png` (o `.jpg`)
- **Alta Definición (Retina):** `banner-1544x500.png` *(Solo se usa como complemento, el banner normal siempre debe existir).*
- *(Opcional)* Diseños adaptados a idiomas Izquierda-a-Derecha o por regiones se pueden hacer añadiendo un sufijo, ej. `banner-772x250-es_ES.png` o `banner-772x250-rtl.png`.

### Capturas de Pantalla (Screenshots)
Muestran la configuración o uso en el dashboard. **Los nombres de archivo deben ser siempre en minúsculas**.
- **Nomenclatura:** `screenshot-1.png`, `screenshot-2.png`, etc. (o `.jpg`).
- **Asociación con el `readme.txt`:** Cada archivo corresponde a una línea en la sección `== Screenshots ==` de tu archivo `readme.txt`.
  - La línea `1.` del `readme.txt` será la leyenda (caption) de `screenshot-1.png`.
  - La línea `2.` será la leyenda de `screenshot-2.png`, y así sucesivamente.

---

## 4. Validar el Readme.txt
El archivo `readme.txt` es vital para el directorio, ya que de ahí se extraen los detalles, versiones, requerimientos, preguntas frecuentes y capturas presentadas en la página web. Antes de enviar actualizaciones, verifica siempre la validez de este archivo en la herramienta oficial:
👉 [Validador de Readme.txt de WordPress.org](https://wordpress.org/plugins/developers/readme-validator/)
