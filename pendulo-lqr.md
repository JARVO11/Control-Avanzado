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

El archivo recibido define:

$$Q=\operatorname{diag}(1,20,0.1,0.1),\qquad R=10.$$

| Peso | Estado o señal | Interpretación |
|---|---|---|
| 1 | θ | Penaliza desplazamiento del brazo |
| 20 | α | Prioriza la desviación del péndulo para la escala de estados usada |
| 0.1 y 0.1 | Velocidades angulares | Penalizan la rapidez de movimiento |
| 10 | Voltaje | Penaliza el esfuerzo de control |

Los pesos deben interpretarse junto con las unidades y escalas. Un R positivo penaliza el voltaje, pero **no impone una saturación física**. No se recibió una bitácora de pruebas que permita afirmar cómo se seleccionó esta combinación.

## 2. Riccati y ganancia

La solución estabilizante P satisface:

$$A^TP+PA-PBR^{-1}B^TP+Q=0,\qquad K=R^{-1}B^TP.$$

En MATLAB:

```matlab
Q = diag([1 20 0.1 0.1]);
R = 10;
[K,P,polosLQR] = lqr(A,B,Q,R);
```

Con los valores recibidos:

$$K\approx\begin{bmatrix}-0.316228&23.245193&-0.594816&1.870087\end{bmatrix}.$$

Se recomputó la ecuación de Riccati con SciPy para verificar los números publicados. No se ejecutó MATLAB en esta revisión; el script descargable permite contrastarlos en el entorno del laboratorio.

## 3. Ley de control y estabilidad

Para referencia nula, u = −Kx. Los polos nominales ideales de A − BK son:

$$\{-14.376823,\;-12.289310,\;-2.895348,\;-1.457926\}\;\mathrm{s}^{-1}.$$

Todos tienen parte real negativa: el modelo lineal ideal con realimentación de estado es asintóticamente estable. Esta comprobación no incluye saturación, filtros de derivación, ruido, muestreo, desconexiones ni dinámica no modelada; no basta para garantizar el desempeño del montaje físico.

## 4. Referencia en el modelo recibido

Simulink forma el vector de referencia y aplica:

$$x_{ref}=\begin{bmatrix}\theta_{ref}&0&0&0\end{bmatrix}^{T},\qquad u=K(x_{ref}-x_f),$$

donde xf contiene los ángulos medidos y las velocidades filtradas. Por eso el bloque con ganancia `K` se llama `u = -K*x`: el signo negativo procede del sumador previo cuando la referencia es cero.

Para una referencia de posición constante, el vector anterior es compatible con el equilibrio del modelo. Si la referencia varía en el tiempo, aquí no se incorporan sus derivadas ni una prealimentación dinámica; no debe afirmarse seguimiento exacto por el simple uso del LQR. El generador guarda frecuencia **0.125 rad/s** y una ganancia externa de **15** antes de convertir de grados a radianes. Confirmar la forma de onda y amplitud del bloque al abrir la versión de laboratorio.

## 5. Ajuste y evidencia pendiente

Para justificar la sintonización se debe registrar cada Q/R probado con el mismo escenario, condiciones iniciales y métricas. Comparar error angular, tiempo de establecimiento, voltaje máximo y RMS. Explicar el compromiso entre rapidez y esfuerzo usando las gráficas reales. Esta página documenta la combinación recibida; no atribuye al equipo ensayos que no se adjuntaron.

Fuente de la formulación: [MathWorks, lqr](https://www.mathworks.com/help/control/ref/lti.lqr.html).
