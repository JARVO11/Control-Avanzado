---
layout: default
title: Inicio
nav_order: 1
permalink: /
---

<section class="course-hero">
  <div>
    <p class="course-eyebrow">CONTROL AVANZADO · PORTAFOLIO</p>
    <h1>Del modelo<br>al <span>equilibrio.</span></h1>
    <p class="course-intro">Proyectos de control, estimación y experimentación. Una bitácora que conecta las ecuaciones con el comportamiento de sistemas reales.</p>
    <div class="course-actions">
      <a class="btn btn-primary" href="{{ '/pendulo-qube3/' | relative_url }}">Explorar el péndulo →</a>
      <a class="btn" href="{{ '/pendulo-archivos/' | relative_url }}">Archivos del proyecto</a>
    </div>
  </div>
  <figure class="lab-panel">
    <div class="lab-panel__meta"><span>PLATAFORMA 01</span><span>QUANSER</span></div>
    <img src="{{ '/assets/img/pendulo/qube3-consigna.png' | relative_url }}" alt="Péndulo rotatorio Qube-Servo 3, imagen de referencia de la consigna">
    <figcaption><strong>Qube-Servo 3</strong><br>Imagen de referencia de la consigna; las pruebas del equipo se documentan por separado.</figcaption>
  </figure>
</section>

<div class="course-strip">
  <div><strong>01 · Modelar</strong><span>Dinámica y espacio de estados</span></div>
  <div><strong>02 · Diseñar</strong><span>LQR y observador</span></div>
  <div><strong>03 · Validar</strong><span>Pruebas y análisis</span></div>
</div>

<div class="section-heading" id="proyectos"><h2>Proyecto en foco</h2><span>01 proyecto documentado</span></div>

<article class="project-feature">
  <div class="project-feature__number">01 /</div>
  <div>
    <span class="status-chip">DOCUMENTACIÓN EN DESARROLLO</span>
    <h3>Péndulo invertido</h3>
    <p>Balance del Qube-Servo 3 mediante retroalimentación LQR y diseño de un observador. Desarrollo matemático, implementación en Simulink y seguimiento de las evidencias de laboratorio.</p>
    <div class="project-feature__links">
      <a href="{{ '/pendulo-qube3/' | relative_url }}">Ver proyecto completo →</a>
      <a href="{{ '/pendulo-requisitos/' | relative_url }}">Revisar entregables</a>
      <a href="{{ '/pendulo-resultados/' | relative_url }}">Resultados y pendientes</a>
    </div>
  </div>
</article>

## Explorar la documentación

<div class="chapter-list">
  <a href="{{ '/pendulo-modelado/' | relative_url }}"><b>01</b><span>Modelado del sistema</span><em>↗</em></a>
  <a href="{{ '/pendulo-lqr/' | relative_url }}"><b>02</b><span>Controlador LQR</span><em>↗</em></a>
  <a href="{{ '/pendulo-observador/' | relative_url }}"><b>03</b><span>Observador de estados</span><em>↗</em></a>
  <a href="{{ '/pendulo-simulink/' | relative_url }}"><b>04</b><span>Implementación en Simulink</span><em>↗</em></a>
  <a href="{{ '/pendulo-resultados/' | relative_url }}"><b>05</b><span>Resultados y discusión</span><em>↗</em></a>
  <a href="{{ '/pendulo-archivos/' | relative_url }}"><b>06</b><span>Archivos y reproducción</span><em>↗</em></a>
</div>

<p class="next-project-note">Este portafolio crecerá con los próximos proyectos de Control Avanzado. Las evidencias experimentales aún no recibidas se identifican dentro de cada sección.</p>
