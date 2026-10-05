# Control Avanzado · Portafolio

Adaptación de la plantilla Just the Docs del portafolio de Integración Mecatrónica.
Primer proyecto: péndulo Qube-Servo 3, LQR y observador.

## Diseño

Edición verde agua, portada dividida y accesos directos a capítulos. Configurada para GitHub Pages en JARVO11/Control-Avanzado.

## Estado

La estructura incluye los cinco entregables del PDF. Las evidencias faltantes se marcan de forma explícita. Destino autorizado: JARVO11/Control-Avanzado. Publicación mediante GitHub Pages desde la rama main. No se ejecutó el hardware ni MATLAB.

1. Revisar `PUBLICAR.md` para configurar un repositorio nuevo.
2. Revisar `pendulo-requisitos.md` para comprobar pendientes.
3. Los programas y PDF están en `assets/files/pendulo/`.
4. Abrir `vista-local/index.html` para una vista local aproximada con navegación; las ecuaciones se renderizan sin conexión con MathJax incluido. La vista local no es una compilación de Jekyll y no debe usarse como fuente de GitHub Pages.

## Navegación del proyecto

Modelado → LQR → Observador → Implementación → Resultados → Archivos.
Cada página tiene un vínculo estable y depende de `parent: "Péndulo Qube-Servo 3"`.

## Añadir proyectos

Crear otro Markdown raíz con `layout: default`, un título, `nav_order` nuevo y `has_children: true`. Sus páginas hijas usan `parent` con exactamente ese título. Añadir una tarjeta en `index.md` y usar siempre enlaces `relative_url` para soportar cualquier nombre de repositorio.

## Trazabilidad

El SLX con nombre nuevo es una copia binaria exacta del recibido. El script original se conserva en `originales/`; el comentado calcula los mismos parámetros y ganancias, explicita C/D y corrige la representación simbólica de Bobs. No se han corregido conexiones ni umbrales del SLX. Ver `PROCEDENCIA.md`.
