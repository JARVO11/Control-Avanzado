---
layout: default
title: "Resultados y discusión"
nav_order: 6
permalink: /pendulo-resultados/
parent: "Péndulo Qube-Servo 3"
---

# Resultados y discusión

## Prueba del sistema

Implementamos el controlador en el Qube-Servo 3 y realizamos pruebas de balance cerca de la vertical superior. El motor corrige la posición del brazo a partir de los ángulos medidos y de las velocidades estimadas para sostener el péndulo.

<figure class="technical-figure video-figure">
  <video controls playsinline preload="metadata" poster="{{ '/assets/img/pendulo/Pendulo.jpg' | relative_url }}">
    <source src="{{ '/assets/videos/ControladorPendulo.mp4' | relative_url }}" type="video/mp4">
    Tu navegador no puede reproducir este video. <a href="{{ '/assets/videos/ControladorPendulo.mp4' | relative_url }}">Descargar video</a>.
  </video>
  <figcaption>Prueba del péndulo en el laboratorio: balance alrededor de la vertical y respuesta al contacto manual.</figcaption>
</figure>

La prueba ilustra tanto el balance como su sensibilidad a cambios externos. Al alejar el péndulo de la región de operación, la corrección del controlador tiene un alcance limitado. Esto es coherente con un diseño calculado a partir de un modelo lineal cercano al equilibrio.

## Resultados del modelo

| Verificación | Resultado | Significado |
|---|---|---|
| Controlabilidad | Rango 4 | El modelo permite actuar sobre sus cuatro estados. |
| Observabilidad con θ y α | Rango 4 | Los estados pueden reconstruirse a partir de ambos ángulos. |
| Polo inestable en lazo abierto | +12.1485 s⁻¹ | El equilibrio superior necesita control. |
| Polos del modelo con LQR ideal | −14.3768, −12.2893, −2.8953 y −1.4579 s⁻¹ | El modelo lineal con realimentación ideal de estado es estable. |
| Polos del observador | −100 s⁻¹, triple | La dinámica interna del observador es estable. |

Estos valores describen el diseño nominal. En el montaje real también intervienen la estimación de velocidades, el ruido de medición, la fricción y las diferencias físicas del equipo.

## Ajustes y comportamiento observado

Probamos diferentes valores de los pesos del LQR para adaptar la respuesta a nuestro Qube-Servo. El objetivo fue mantener el equilibrio sin exigir correcciones demasiado bruscas al motor. La respuesta depende tanto de las ganancias como de la calidad de las mediciones que regresan al controlador.

Las pequeñas variaciones entre equipos pueden modificar su respuesta respecto de los parámetros nominales. Además, el ruido en las lecturas de un encoder puede pasar al cálculo de las velocidades y provocar correcciones rápidas del motor. Estos efectos explican por qué una misma configuración no produce necesariamente el mismo resultado en todas las unidades.

## Conclusión

El controlador propuesto en este proyecto funciona correctamente para mantener el péndulo cerca de la posición vertical superior, dentro de las condiciones de operación del balance. El desarrollo nos permitió relacionar el modelo matemático con la implementación física: los parámetros del sistema definen las matrices de estado, el LQR calcula la acción de control y los observadores proporcionan las velocidades utilizadas en la realimentación.

Para obtener una respuesta adecuada tuvimos que probar diferentes valores del controlador LQR. Aunque los equipos Qube-Servo comparten el mismo diseño, pueden presentar diferencias en sus características físicas, en la fricción y en el ajuste mecánico. Estas diferencias cambian la respuesta real respecto del modelo nominal y afectan la relación entre las mediciones y los datos utilizados para calcular las ganancias. A ello se suma el ruido en las lecturas de los encoders, que puede provocar variaciones en las velocidades estimadas y perturbaciones en la acción del motor.

Por esta razón, consideramos conveniente desarrollar un controlador más robusto e incorporar cancelación activa de perturbaciones. Una estrategia de este tipo permitiría estimar y compensar parte de los efectos que el modelo nominal no representa, al mismo tiempo que se mejora el tratamiento del ruido de medición. El objetivo sería conservar el equilibrio con menos oscilaciones y lograr una respuesta menos sensible a las diferencias entre equipos y a las perturbaciones externas.

El proyecto demuestra la utilidad del LQR y de la estimación de estados para resolver un problema de equilibrio real. También muestra que un buen resultado depende de combinar el cálculo teórico con el ajuste experimental y con una lectura cuidadosa del comportamiento del sistema.
