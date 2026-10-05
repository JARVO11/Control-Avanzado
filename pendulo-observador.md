---
layout: default
title: "Diseño y ecuaciones del observador"
nav_order: 4
permalink: /pendulo-observador/
parent: "Péndulo Qube-Servo 3"
---


# Diseño y ecuaciones del observador

## 1. Estructura exigida

La figura 3 de la consigna utiliza únicamente la salida angular medida. No incorpora la señal de comando del motor. Se documenta esa estructura específica; no se sustituye por un observador de Luenberger de cuatro estados con entrada Bu.

<figure class="technical-figure"><img src="{{ '/assets/img/pendulo/observador-consigna.png' | relative_url }}" alt="Figura 3: observador con tres integradores y ganancias l, m y beta"><figcaption>Diagrama original del PDF, página 5. La ganancia l del dibujo se representa como L en el script, para distinguirla de la distancia al centro de masa del péndulo.</figcaption></figure>

## 2. Ecuaciones obtenidas del diagrama

Sea q la medición angular, q̂ su estimación, v̂ la estimación de velocidad y z la salida del integrador situado a la derecha. El primer sumador produce ε = q − q̂; el siguiente produce ε − βz. Las tres ecuaciones son:

$$\dot{\hat q}=\hat v,\qquad
\dot{\hat v}=L(q-\hat q)+mz,\qquad
\dot z=(q-\hat q)-\beta z.$$

Con η = [q̂, v̂, z]ᵀ:

$$\dot\eta=A_o\eta+B_oq,\qquad
A_o=\begin{bmatrix}0&1&0\\-L&0&m\\-1&0&-\beta\end{bmatrix},\quad
B_o=\begin{bmatrix}0\\L\\1\end{bmatrix}.$$

z es un estado auxiliar filtrado del error. **No es directamente un torque ni una perturbación física identificada**; para llamarlo estimación de una perturbación debe justificarse la relación con la dinámica y sus unidades.

## 3. Cálculo de ganancias

Al desarrollar el determinante:

$$\det(sI-A_o)=s^3+\beta s^2+Ls+L\beta+m.$$

El script selecciona tres polos nominales en −a, con a = 100 s⁻¹:

$$P_d(s)=(s+a)^3=s^3+3as^2+3a^2s+a^3.$$

Por igualdad de coeficientes:

$$\boxed{\beta=3a=300,\quad L=3a^2=30000,\quad m=a^3-L\beta=-8000000.}$$

Así, Po(s) = (s + 100)³. La estabilidad continua es interna, con tres polos en −100 s⁻¹. Debido a la sensibilidad numérica de raíces repetidas, `eig` puede mostrar valores ligeramente distintos o pequeñas partes imaginarias alrededor de −100.

## 4. Ecuaciones para cada ángulo

Para reconstruir ambos pares de posición y velocidad se necesitan dos canales de esta estructura, uno por medición:

$$\begin{aligned}
\dot{\hat\theta}&=\hat\omega_\theta,&
\dot{\hat\omega}_\theta&=L(\theta-\hat\theta)+mz_\theta,&
\dot z_\theta&=\theta-\hat\theta-\beta z_\theta,\\
\dot{\hat\alpha}&=\hat\omega_\alpha,&
\dot{\hat\omega}_\alpha&=L(\alpha-\hat\alpha)+mz_\alpha,&
\dot z_\alpha&=\alpha-\hat\alpha-\beta z_\alpha.
\end{aligned}$$

El vector estimado sería x̂ = [θ̂, α̂, ω̂θ, ω̂α]ᵀ. Estos dos canales describen la implementación pendiente; **no están completos ni acoplados al LQR en el archivo recibido**.

## 5. Estabilidad y error de estimación

Para estudiar el error con la convención pedida por el PDF, defínanse e₁ = q̂ − q y e₂ = v̂ − q̇:

$$\frac{d}{dt}\begin{bmatrix}e_1\\e_2\\z\end{bmatrix}
=A_o\begin{bmatrix}e_1\\e_2\\z\end{bmatrix}
+\begin{bmatrix}0\\-\ddot q\\0\end{bmatrix}.$$

La respuesta homogénea decae porque Ao es estable. Pero el error es forzado por la aceleración de la señal real. Para q constante o una rampa ideal, q̈ = 0 y los errores decaen; para movimiento general no se deduce error cero solamente a partir de los polos. Por ejemplo, si q̈ = c constante, el error estacionario de posición es:

$$e_{1,ss}=-\frac{\beta c}{L\beta+m}=-\frac{3c}{a^2}.$$

Con condiciones iniciales nulas, la transferencia de la medición a la posición estimada es:

$$\frac{\hat Q(s)}{Q(s)}=\frac{Ls+L\beta+m}{s^3+\beta s^2+Ls+L\beta+m}.$$

Esta expresión permite analizar respuesta en frecuencia y sensibilidad al ruido. Aumentar a acelera la dinámica nominal, pero exige revisar ruido, amplitudes transitorias y resolución temporal. No se recibió comparación experimental de ganancias.

## 6. Estado real en Simulink

Dentro de `Qube With Pendulum` existe un canal con tres integradores y ganancias `L`, `beta`, `m`. La entrada positiva del sumador `Sum1` no tiene cable de medición. Tampoco hay conexión desde sus estimaciones al controlador. El LQR utiliza el subsistema `State X`, que calcula velocidades con derivación filtrada de polo −50.

Para completar el entregable se requiere conectar la medición correspondiente, implementar el segundo canal si se estiman ambos ángulos, formar el vector en el orden correcto y registrar mediciones, estimaciones y errores. Estas conexiones deben validarse antes de atribuir funcionamiento al observador.
