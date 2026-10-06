---
layout: default
title: "Diseño del controlador LQR"
nav_order: 3
permalink: /pendulo-lqr/
parent: "Péndulo Qube-Servo 3"
---


# Diseño del controlador LQR

## 1. Función de costo y pesos

Para el modelo continuo, la regulación alrededor del equilibrio minimiza:

$$J=\int_0^\infty\left(x^TQx+u^TRu\right)dt.$$

En el script del proyecto usamos:

$$Q=\operatorname{diag}(1,20,0.1,0.1),\qquad R=10.$$

| Peso | Estado o señal | Interpretación |
|---|---|---|
| 1 | θ | Penaliza desplazamiento del brazo |
| 20 | α | Prioriza la desviación del péndulo para la escala de estados usada |
| 0.1 y 0.1 | Velocidades angulares | Penalizan la rapidez de movimiento |
| 10 | Voltaje | Penaliza el esfuerzo de control |

Los pesos deben interpretarse junto con las unidades y escalas. Un R positivo penaliza el voltaje, pero **no impone una saturación física**.

## 2. Riccati y ganancia

La solución estabilizante P satisface:

$$A^TP+PA-PBR^{-1}B^TP+Q=0,\qquad K=R^{-1}B^TP.$$

En MATLAB:

```matlab
Q = diag([1 20 0.1 0.1]);
R = 10;
[K,P,polosLQR] = lqr(A,B,Q,R);
```

Con los parámetros nominales del proyecto:

$$K\approx\begin{bmatrix}-0.316228&23.245193&-0.594816&1.870087\end{bmatrix}.$$

La función `lqr` calcula K a partir de A, B, Q y R. La matriz K combina el error de cada estado para obtener el voltaje de control.

## 3. Ley de control y estabilidad

Para referencia nula, u = −Kx. Los polos nominales ideales de A − BK son:

$$\{-14.376823,\;-12.289310,\;-2.895348,\;-1.457926\}\;\mathrm{s}^{-1}.$$

Todos tienen parte real negativa: el modelo lineal ideal con realimentación de estado es asintóticamente estable. Esta comprobación no incluye saturación, filtros de derivación, ruido, muestreo, desconexiones ni dinámica no modelada; no basta para garantizar el desempeño del montaje físico.

## 4. Referencia en Simulink

Simulink forma el vector de referencia y aplica:

$$x_{ref}=\begin{bmatrix}\theta_{ref}&0&0&0\end{bmatrix}^{T},\qquad u=K(x_{ref}-x_f),$$

donde xf contiene los ángulos medidos y las velocidades estimadas por el observador. Por eso el bloque con ganancia `K` se llama `u = -K*x`: el signo negativo procede del sumador previo cuando la referencia es cero.

Para una referencia de posición constante, el vector anterior es compatible con el equilibrio del modelo. Si la referencia varía en el tiempo, aquí no se incorporan sus derivadas ni una prealimentación dinámica; no debe afirmarse seguimiento exacto por el simple uso del LQR. El generador guarda frecuencia **0.125 rad/s** y una ganancia externa de **15** antes de convertir de grados a radianes. La ganancia de 15 escala la referencia del brazo y es independiente del umbral que activa el balance.

## 5. Ajuste en el laboratorio

Durante las pruebas utilizamos diferentes valores de los pesos del LQR hasta obtener una respuesta adecuada en nuestro equipo. El ajuste busca un equilibrio entre mantener el péndulo vertical, regular el brazo y evitar movimientos demasiado bruscos del motor.

Aumentar el peso del ángulo del péndulo hace que el diseño dé mayor importancia a su desviación. Aumentar R penaliza más el voltaje. Estos cambios se evalúan en conjunto, porque una respuesta más rápida puede aumentar el esfuerzo del motor y la sensibilidad al ruido.

Las diferencias físicas entre unidades del Qube-Servo, como la fricción y el ajuste mecánico, pueden cambiar la respuesta respecto del modelo nominal. Por eso los valores que funcionan en un equipo no necesariamente producen el mismo comportamiento en otro.

Fuente: [MathWorks, función lqr](https://www.mathworks.com/help/control/ref/lti.lqr.html).
