# Procedencia y límites de la revisión

- Plantilla: https://github.com/JARVO11/documentacion-robot-limpia-playas ; descargada durante esta revisión.
- Se reutilizan logotipo, favicon y estructura Just the Docs; el diseño usa una nueva paleta verde agua y una portada dividida; se adapta el encabezado para fórmulas y el pie para Control Avanzado y atribución.
- No se modificó ni publicó el repositorio fuente.
- PDF: Proyecto_CAR_O26.pdf, recibido del usuario. Se conserva completo y se extraen las figuras 2 y 3 para documentación del péndulo. No se documenta el Aero.
- MATLAB: ProyectoControlDinal.m, recibido del usuario. Se conserva y se añade una versión comentada equivalente con C/D y Bobs numérica.
- Simulink: qs3_lqr_ctrl.slx, recibido del usuario. Copia renombrada sin alteraciones binarias. Inspección de XML y miniatura; sin ejecución MATLAB/QUARC.
- Valores nominales A/B/K y polos verificados por cálculo independiente con SciPy. El modelo físico, los límites, los Scopes y la compatibilidad de bibliotecas no se ejecutaron.
- La vista local aproxima el marco visual de Just the Docs y usa el nuevo CSS verde agua. La compilación final y búsqueda del tema se validan al publicar en Pages.

- MathJax 3.2.2 (tex-svg.js) incluido para fórmulas sin conexión; licencia Apache 2.0 conservada en assets/js/mathjax/LICENSE.

## Verificación final

- 10 páginas con navegación y destinos internos válidos.
- Copia SLX idéntica al original, comprobada por SHA-256.
- Ecuación de Riccati verificada (residuo de norma aproximada 9.2e-13).
- Polinomio del observador: [1, 300, 30000, 1000000], correspondiente a m = -8000000.
- Vista local inspeccionada en 1440 px y 390 px, sin desbordamiento de página en la vista móvil comprobada. Las ecuaciones extensas tienen desplazamiento horizontal local.
- Fórmulas de modelado y observador renderizadas sin errores MathJax; comprobada la compatibilidad con etiquetas math/tex de Kramdown (7 expresiones en la prueba de LQR, incluida la expresión de comprobación).
- No se realizó una compilación completa de Jekyll ni una ejecución MATLAB/Simulink. La vista local aproxima el marco de la plantilla y emplea su CSS real.

## Actualización visual

Paleta verde agua y nueva distribución de portada solicitadas por el usuario. Se revisaron rutas internas. La vista previa visual anterior corresponde al diseño rojo; el navegador no permitió abrir archivos locales para volver a inspeccionar esta edición. Publicación pendiente de autenticación.
