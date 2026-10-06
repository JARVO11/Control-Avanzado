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
<p>Diseño e implementación de un controlador LQR con estimación de velocidades para el péndulo rotatorio Quanser Qube-Servo 3.</p>
</div>

## Nuestro proyecto

En esta práctica desarrollamos un controlador para mantener el péndulo cerca de la vertical superior y regular la posición del brazo. Partimos del modelo matemático, calculamos las ganancias del LQR y del observador, y conectamos el sistema físico con Simulink mediante QUARC.

<figure class="technical-figure"><a href="{{ '/assets/img/pendulo/Pendulo.jpg' | relative_url }}" target="_blank" rel="noopener"><img src="{{ '/assets/img/pendulo/Pendulo.jpg' | relative_url }}" alt="Montaje del péndulo Qube-Servo 3 en el laboratorio" loading="lazy" style="max-height:520px;width:auto"></a><figcaption>Montaje de laboratorio con el péndulo en posición vertical y el modelo de Simulink al fondo.</figcaption></figure>

## Del cálculo a la prueba

| Etapa | Elementos del proyecto |
|---|---|
| Modelado | Cuatro estados: dos ángulos y dos velocidades angulares. |
| Diseño LQR | Matrices Q y R, ganancia K y polos del modelo en lazo cerrado. |
| Estimación | Dos canales del observador, uno para el brazo y otro para el péndulo. |
| Implementación | Ángulos de los encoders y velocidades estimadas para la realimentación. |
| Prueba | Balance del péndulo y análisis de su sensibilidad a perturbaciones. |

## Documentación

1. [Objetivos del proyecto]({{ '/pendulo-requisitos/' | relative_url }}).
2. [Modelado del sistema]({{ '/pendulo-modelado/' | relative_url }}).
3. [Diseño del controlador LQR]({{ '/pendulo-lqr/' | relative_url }}).
4. [Diseño y ecuaciones del observador]({{ '/pendulo-observador/' | relative_url }}).
5. [Implementación en Simulink]({{ '/pendulo-simulink/' | relative_url }}).
6. [Resultados, video y conclusión]({{ '/pendulo-resultados/' | relative_url }}).
7. [Archivos del proyecto]({{ '/pendulo-archivos/' | relative_url }}).
