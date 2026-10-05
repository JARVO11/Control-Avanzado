---
layout: default
title: "Resultados y discusión"
nav_order: 6
permalink: /pendulo-resultados/
parent: "Péndulo Qube-Servo 3"
---


# Resultados y discusión

<div class="evidence-note"><strong>Evidencias pendientes.</strong> No se adjuntaron registros temporales, gráficas de ensayos ni videos. Los resultados de esta página son cálculos nominales reproducidos a partir del script; no demuestran el funcionamiento físico.</div>

## Resultados analíticos disponibles

| Verificación | Resultado | Alcance |
|---|---|---|
| Controlabilidad | Rango 4 | Modelo nominal |
| Observabilidad con θ y α | Rango 4 | Modelo nominal |
| Polo inestable en lazo abierto | +12.1485 s⁻¹ | Equilibrio superior |
| Polos ideales del LQR | −14.3768, −12.2893, −2.8953, −1.4579 s⁻¹ | Realimentación ideal de estado |
| Polos nominales del observador | −100 s⁻¹, triple | Estabilidad interna; no prueba error cero para cualquier trayectoria |

## Ensayos propuestos para completar la entrega

Los siguientes escenarios son un plan de documentación, no pruebas ya realizadas. Deben respetar las condiciones y límites autorizados por el laboratorio.

| Escenario | Registrar | Pregunta de análisis |
|---|---|---|
| Captura manual y balance cerca de la vertical | α, θ, voltaje, habilitación e instante de liberación | ¿Se mantiene el péndulo en la región de balance? |
| Referencia fija del brazo | Referencia, estados, estimaciones y errores | ¿Cuál es el error residual y cuánto tarda en estabilizarse? |
| Referencia variable del brazo | Misma referencia y condiciones para las comparaciones | ¿Qué desfase aparece y cómo afecta al péndulo? |
| Perturbación pequeña autorizada | Momento de perturbación, estados y voltaje | ¿Recupera el equilibrio sin esfuerzo excesivo? |
| Condiciones iniciales distintas del observador | Mediciones, estimaciones y errores | ¿Cómo converge el error y qué transitorios aparecen? |

## Gráficas necesarias

1. θ y θ̂ contra tiempo, junto con la referencia del brazo.
2. α y α̂ contra tiempo, con referencia vertical de cero.
3. Velocidades de referencia/medición disponible y estimaciones; especificar si la comparación utiliza derivadas filtradas en lugar de sensores independientes.
4. Errores por estado: x̂i − xi o frente a la referencia de validación explícitamente indicada.
5. Voltaje de control en V y señal de habilitación.

Todas deben incluir nombres de señales, unidades, tiempo en segundos, condiciones iniciales, Q/R y ganancias del observador. Si no existe una medición independiente de velocidad, no llamar “velocidad verdadera” a la derivada filtrada del encoder.

## Métricas sugeridas

$$\operatorname{RMSE}_i=\sqrt{\frac1N\sum_{k=1}^{N}(\hat x_i[k]-x_i[k])^2},\quad
u_{RMS}=\sqrt{\frac1N\sum_{k=1}^{N}u[k]^2},\quad
u_{max}=\max_k|u[k]|.$$

Usar las mismas unidades en cada comparación. Para el tiempo de establecimiento de una regulación a cero, definir una banda angular absoluta (rad o grados) y el intervalo durante el cual se exige permanecer dentro de ella; un porcentaje de una referencia cero no define una tolerancia útil. Estos cálculos sobre muestras no cambian la naturaleza continua del diseño LQR.

| Ensayo | Condiciones y ganancias | RMSE por estado | Tiempo de establecimiento | Voltaje máx./RMS | Evidencia |
|---|---|---|---|---|---|
| Pendiente | Por registrar | Por calcular | Por calcular | Por calcular | Datos y video pendientes |

## Discusión que sí permiten los archivos

La elección Q22 = 20 muestra la prioridad nominal del ángulo del péndulo para las escalas usadas; R = 10 penaliza esfuerzo. Los polos ideales verifican estabilización del modelo lineal. El comportamiento real puede diferir por las velocidades filtradas, los efectos de muestreo, fricción, límites de voltaje y la distancia al punto de linealización.

No se puede concluir que el observador mejora el control: en el archivo recibido no participa en la realimentación. Tampoco se puede atribuir convergencia de todos los estados sin medir errores bajo movimiento y perturbaciones.

## Video del equipo

**Pendiente de incorporar.** Añadir un video donde se vea la captura manual y el balance del péndulo, y de ser posible las señales en pantalla. Documentar la configuración usada. Una fotografía de catálogo no sustituye esta evidencia.

## Conclusión provisional

El material recibido permite reproducir el diseño nominal del LQR y el cálculo de ganancias del observador. La validación experimental, la conexión completa del observador y la justificación de la sintonización siguen pendientes; las conclusiones finales deberán incorporar esas evidencias.
