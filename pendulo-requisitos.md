---
layout: default
title: "Requisitos y entregables"
nav_order: 1
permalink: /pendulo-requisitos/
parent: "Péndulo Qube-Servo 3"
---


# Requisitos y entregables

La consigna *Proyecto Práctico - Control Avanzado y Robótica*, fechada el 24 de septiembre de 2026, define la plataforma **Qube-Servo 3, equipo B**. Los cinco entregables técnicos aparecen en las páginas 4–5; la rúbrica está en la página 6. La fecha de presentación indicada es el 2 de octubre de 2026.

[Consultar la consigna completa]({{ '/assets/files/pendulo/especificaciones_proyecto_control_avanzado.pdf' | relative_url }}).

## Correspondencia con los cinco entregables

| Requisito del PDF | Sección del portafolio | Cobertura actual y evidencia que falta |
|---|---|---|
| 1. Descripción, procedimiento, modelado y demostración paso a paso de la dinámica linealizada | [Modelado]({{ '/pendulo-modelado/' | relative_url }}) | Desarrollo matemático, parámetros y matrices documentados. Falta validar parámetros en laboratorio. |
| 2. Ajuste de Q y R y cálculo de K del LQR | [LQR]({{ '/pendulo-lqr/' | relative_url }}) | Valores recibidos, Riccati, K y polos documentados. Falta historial de ajustes y justificación experimental. |
| 3. Cálculo de ganancias del observador; estabilidad y convergencia del error | [Observador]({{ '/pendulo-observador/' | relative_url }}) | Polinomio, ganancias y estabilidad interna documentados. Falta verificar errores de estimación con datos; estabilidad interna no garantiza error nulo ante toda señal. |
| 4. Obtención de las ecuaciones del observador a partir de la figura 3 | [Observador]({{ '/pendulo-observador/' | relative_url }}) | Ecuaciones para cada ángulo y forma matricial. Falta completar su conexión en el modelo. |
| 5. Gráficas de estados y estimaciones en distintos escenarios; análisis y discusión | [Resultados]({{ '/pendulo-resultados/' | relative_url }}) | Se definen escenarios, señales y métricas. Pendientes datos, gráficas, comparación y conclusiones experimentales. |

## Entrega en Brightspace

| Entregable | Situación |
|---|---|
| Enlace al portafolio digital | Paquete web preparado; repositorio destino y publicación pendientes |
| Programas legibles, estructurados y comentados | Modelo recibido, script comentado equivalente y originales disponibles |
| Video o carpeta con videos del sistema físico funcionando | Pendiente de recibir |

## Revisión de implementación

- La consigna indica balance dentro de ±10°. La función del modelo recibido utiliza ±15°: debe ajustarse o documentarse una autorización del docente.
- El LQR es continuo; Simulink guarda un paso fijo de 0.002 s. Esto no convierte el diseño automáticamente en un LQR discreto.
- La entrada positiva del sumador de error del observador está libre; sus estimaciones no se conectan al vector de realimentación.
- El vector que actualmente usa el controlador contiene ángulos medidos y velocidades obtenidas mediante derivación filtrada.

## Rúbrica y defensa

La evaluación considera implementación técnica, diseño y ajuste de parámetros, análisis de resultados, discusión, calidad del repositorio y defensa individual. Para completar la evidencia, cada integrante debe explicar la elección de estados, el significado de Q/R/K, las ganancias del observador, las convenciones de signo y las limitaciones observadas.

## Información por incorporar

Integrantes y grupo; validación de parámetros; versión definitiva del modelo con observador; capturas legibles; datos o gráficas de varios ensayos; video del equipo; decisiones de sintonización y conclusiones respaldadas por mediciones.
