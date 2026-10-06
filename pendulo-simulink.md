---
layout: default
title: "Implementación en Simulink"
nav_order: 5
permalink: /pendulo-simulink/
parent: "Péndulo Qube-Servo 3"
---

# Implementación en Simulink

## Modelo general

Implementamos el control en `qs3_lqr_ctrl.slx`. El modelo compara la referencia del brazo con el vector de estados, calcula el voltaje mediante la ganancia K y lo envía al Qube-Servo 3. Las mediciones regresan al controlador para cerrar el lazo.

<figure class="technical-figure"><a href="{{ '/assets/img/pendulo/01_modelo_general.png' | relative_url }}" target="_blank" rel="noopener"><img src="{{ '/assets/img/pendulo/01_modelo_general.png' | relative_url }}" alt="Modelo general del controlador LQR en Simulink" loading="lazy" ></a><figcaption>Diagrama general: referencia, controlador LQR, habilitación de balance, equipo y señales de seguimiento.</figcaption></figure>

El generador produce la referencia del brazo. La ganancia 15 la escala en grados y el bloque `D2R` la convierte a radianes. El vector de referencia es [θref, 0, 0, 0]ᵀ: buscamos la posición deseada del brazo, el péndulo vertical y velocidades nulas.

El bloque `MATLAB Function` habilita el balance cuando el ángulo del péndulo está entre −15° y 15°. El selector aplica el voltaje del LQR dentro de esa región y 0 V fuera de ella. La referencia de 15° del brazo y el umbral de balance son parámetros distintos.

## Conexión con el Qube-Servo 3

<figure class="technical-figure"><a href="{{ '/assets/img/pendulo/02_planta_y_observador.png' | relative_url }}" target="_blank" rel="noopener"><img src="{{ '/assets/img/pendulo/02_planta_y_observador.png' | relative_url }}" alt="Interfaz del Qube-Servo 3 y procesamiento de estados" loading="lazy" ></a><figcaption>Qube With Pendulum: envío de voltaje, lectura de encoders, conversión a ángulos y cálculo de estados.</figcaption></figure>

La interfaz `Qube-Servo 3 - IO (QAL)` envía el comando del motor y lee los encoders del brazo y del péndulo. `Counts to Angles` convierte las cuentas en radianes y `State X` combina los ángulos con las velocidades estimadas.

La ganancia −1 antes del motor establece el sentido positivo de giro utilizado por el modelo. También se cambia el signo de la lectura del brazo para que la medición y el comando sigan la misma convención.

## Conversión de encoders

<figure class="technical-figure"><a href="{{ '/assets/img/pendulo/03_conversion_encoders.png' | relative_url }}" target="_blank" rel="noopener"><img src="{{ '/assets/img/pendulo/03_conversion_encoders.png' | relative_url }}" alt="Conversión de cuentas de encoder a ángulos" loading="lazy" ></a><figcaption>Conversión de las lecturas del brazo y del péndulo a radianes.</figcaption></figure>

Usamos 2048 cuentas por revolución, equivalentes a 512 × 4. Las conversiones son:

$$\theta=-n_\theta\frac{2\pi}{2048},\qquad
\alpha=\operatorname{mod}\left(n_\alpha\frac{2\pi}{2048},2\pi\right)-\pi.$$

El bloque `mod` mantiene la lectura del péndulo dentro de una vuelta. El desplazamiento −π coloca el cero en la vertical superior, de acuerdo con la referencia del encoder.

## Estados y velocidades

<figure class="technical-figure"><a href="{{ '/assets/img/pendulo/04_estados_y_velocidades.png' | relative_url }}" target="_blank" rel="noopener"><img src="{{ '/assets/img/pendulo/04_estados_y_velocidades.png' | relative_url }}" alt="Observadores de los dos ángulos dentro de State X" loading="lazy" style="max-height:850px;width:auto"></a><figcaption>Los observadores calculan las velocidades que se incorporan al vector de realimentación.</figcaption></figure>

Cada canal compara el ángulo medido con su estimación. Las ganancias L, m y β corrigen la dinámica de los integradores. La primera salida integrada representa la velocidad estimada y la segunda, la posición estimada.

El controlador utiliza:

$$x_f=\begin{bmatrix}\theta&\alpha&\hat\omega_\theta&\hat\omega_\alpha\end{bmatrix}^{T}.$$

Los dos primeros elementos provienen de los encoders; los dos últimos, de los observadores. Las ecuaciones y el cálculo de las ganancias se explican en [Diseño del observador]({{ '/pendulo-observador/' | relative_url }}).

## Configuración de ejecución

| Parámetro | Configuración |
|---|---|
| Plataforma | Qube-Servo 3 con péndulo |
| Entorno del modelo | MATLAB/Simulink R2026a |
| Solver | ode1, Euler |
| Paso fijo | 0.002 s |
| Tiempo final | inf |
| Interfaz de ejecución | QUARC para Windows de 64 bits |

Los Scopes muestran el ángulo del brazo, el ángulo del péndulo, el voltaje del motor y la señal de habilitación. La visualización angular se convierte a grados; los cálculos del controlador se realizan en radianes.
