---
layout: default
title: "Péndulo Qube-Servo 3"
nav_order: 2
has_children: true
permalink: /pendulo-qube3/
---

<div class="project-page-header">
<p class="portfolio-eyebrow">PROYECTO 01 · CONTROL AVANZADO</p>
<h1>Péndulo invertido</h1>
<p>Balance del péndulo rotatorio Quanser Qube-Servo 3 mediante retroalimentación LQR y diseño de un observador basado en la salida medida.</p>
</div>

## Objetivo y alcance

Mantener el péndulo alrededor de la vertical superior y regular el brazo rotatorio. La puesta en operación se realiza levantando manualmente el péndulo hasta la región de balance; no se requiere una maniobra automática de swing-up. La consigna define una región cercana a la vertical de ±10°.

<figure class="technical-figure"><img src="{{ '/assets/img/pendulo/qube3-consigna.png' | relative_url }}" alt="Plataforma Qube-Servo 3 con péndulo rotatorio" style="max-height:380px"><figcaption>Imagen de referencia extraída de la figura 2 de la consigna, página 3. No es una fotografía de la prueba del equipo.</figcaption></figure>

## Estado de la documentación

| Elemento | Evidencia disponible |
|---|---|
| Modelo matemático y diseño LQR | Script con parámetros nominales, Q, R, K y polos |
| Diseño del observador | Cálculo algebraico de L, m y β y diagrama en Simulink |
| Integración del observador | Pendiente: la entrada de medición del observador está desconectada y sus salidas no alimentan el LQR |
| Ensayos, gráficas y video | Pendientes de incorporar; no están incluidos en los archivos recibidos |
| Equipo e integrantes | Pendiente de completar |

El análisis corresponde a los archivos recibidos, no a una ejecución del equipo físico. El proyecto todavía requiere evidencias e integración para demostrar todos los puntos de la consigna.

## Ruta de lectura

1. [Requisitos y entregables]({{ '/pendulo-requisitos/' | relative_url }}).
2. [Modelado del sistema]({{ '/pendulo-modelado/' | relative_url }}).
3. [Diseño del controlador LQR]({{ '/pendulo-lqr/' | relative_url }}).
4. [Ganancias y ecuaciones del observador]({{ '/pendulo-observador/' | relative_url }}).
5. [Implementación en Simulink]({{ '/pendulo-simulink/' | relative_url }}).
6. [Resultados y discusión]({{ '/pendulo-resultados/' | relative_url }}).
7. [Archivos y reproducción]({{ '/pendulo-archivos/' | relative_url }}).
