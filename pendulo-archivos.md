---
layout: default
title: "Archivos y reproducción"
nav_order: 7
permalink: /pendulo-archivos/
parent: "Péndulo Qube-Servo 3"
---


# Archivos y reproducción

## Descargas

| Archivo | Contenido |
|---|---|
| [especificaciones_proyecto_control_avanzado.pdf]({{ '/assets/files/pendulo/especificaciones_proyecto_control_avanzado.pdf' | relative_url }}) | Consigna original completa; la documentación aplica solamente al péndulo |
| [pendulo_qube3_lqr.slx]({{ '/assets/files/pendulo/pendulo_qube3_lqr.slx' | relative_url }}) | Modelo recibido, con nombre descriptivo; contenido binario sin modificar |
| [parametros_lqr_observador_pendulo.m]({{ '/assets/files/pendulo/parametros_lqr_observador_pendulo.m' | relative_url }}) | Versión comentada de los cálculos, con los mismos parámetros, Q/R y ganancias; incorpora C/D y Bobs numérica |
| [exportar_diagramas_pendulo.m]({{ '/assets/files/pendulo/exportar_diagramas_pendulo.m' | relative_url }}) | Exportación de cuatro diagramas PNG desde MATLAB, sin ejecutar el modelo |
| [ProyectoControlDinal.m original]({{ '/assets/files/pendulo/originales/ProyectoControlDinal.m' | relative_url }}) | Script original conservado para comparación |
| [qs3_lqr_ctrl.slx original]({{ '/assets/files/pendulo/originales/qs3_lqr_ctrl.slx' | relative_url }}) | Modelo con el nombre original |

## Preparar el entorno

1. Descargar el modelo y el script comentado a la misma carpeta.
2. Abrir MATLAB con Simulink, Control System Toolbox y las bibliotecas QUARC usadas por el laboratorio. El modelo fue guardado en R2025b Update 2; verificar compatibilidad antes de usar una versión anterior.
3. Ejecutar `parametros_lqr_observador_pendulo`. El script prepara A, B, C, D, K, L, m y beta; no abre ni inicia el hardware.
4. Abrir `pendulo_qube3_lqr.slx` y revisar enlaces de biblioteca y configuración HIL.
5. Resolver los pendientes de la sección de implementación y validar las convenciones de signos con el docente antes de una ejecución física.

El original usa variables simbólicas para el polinomio. Allí `syms ... l ...` reutiliza el nombre de la longitud al centro de masa y Bobs queda simbólica porque se define antes de asignar las ganancias numéricas. La versión comentada separa `l_cm` de la ganancia `L`, calcula las mismas ganancias por igualdad de coeficientes y define Bobs numérica al final. No necesita Symbolic Math Toolbox.

## Exportar imágenes

Ejecutar `exportar_diagramas_pendulo` desde la carpeta de descargas. Generará la carpeta `diagramas_pendulo` con las vistas principal, planta/interfaz, encoders y estados. El script no guarda cambios en el SLX ni ejecuta la simulación. No ha sido ejecutado aquí porque MATLAB no está disponible.

Para actualizar la página, copiar las imágenes exportadas a `assets/img/pendulo/` y añadirlas a la sección de implementación. Las gráficas temporales se incorporan aparte, a partir de registros de ensayo o capturas de los Scopes.
