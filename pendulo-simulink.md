---
layout: default
title: "Implementación en Simulink"
nav_order: 5
permalink: /pendulo-simulink/
parent: "Péndulo Qube-Servo 3"
---


# Implementación en Simulink

## Vista disponible

<figure class="technical-figure"><img src="{{ '/assets/img/pendulo/modelo-miniatura.png' | relative_url }}" alt="Miniatura original del modelo Simulink recibido" width="500"><figcaption>Miniatura incrustada en el SLX, de 500 × 500 píxeles. Permite reconocer la estructura general; no sustituye una exportación legible de los bloques.</figcaption></figure>

## Flujo real del archivo recibido

| Etapa | Implementación observada |
|---|---|
| Referencia | `Signal Generator` → ganancia 15 → conversión a radianes → vector [θref, 0, 0, 0] |
| Error y control | `Sum`: xref − xf; ganancia matricial `K` |
| Activación | `MATLAB Function`: salida 1 cuando −15° ≤ α ≤ 15°; 0 en otro caso |
| Selector de voltaje | `MultiPortSwitch`: selecciona 0 V o salida del LQR según activación |
| Interfaz física | `Qube With Pendulum` → `Qube-Servo 3 - IO (QAL)` con bloques QUARC HIL |
| Adquisición | Encoders → `Counts to Angles` → ángulos θ y α |
| Estados de control | `State X` agrupa ángulos medidos y velocidades filtradas |
| Observación | Canal de tres integradores dibujado en paralelo, actualmente sin medición ni realimentación al LQR |
| Visualización | Scopes `Base (deg)`, `Pendulum (deg)`, `Vm (V)` y `Scope` de habilitación |

## Encoders y signos

El modelo usa 2048 cuentas por revolución (512 × 4) en la conversión configurada:

$$\theta=-n_\theta\frac{2\pi}{2048},\qquad
\alpha=\operatorname{mod}\left(n_\alpha\frac{2\pi}{2048},2\pi\right)-\pi.$$

Existe además una ganancia −1 antes del comando físico del motor, rotulada `For +ve CCW`. Estas ganancias implementan convenciones de sentido de giro y lectura. No deben eliminarse por considerarlas redundantes; su correspondencia con el hardware debe verificarse en laboratorio. El desplazamiento −π centra la lectura del péndulo en la vertical superior, según la inicialización del encoder.

## Velocidades usadas por el LQR

Cada canal de `State X` contiene un integrador, un sumador y una ganancia 50:

$$\dot z_f=50(q-z_f),\qquad\hat v_f=50(q-z_f),\qquad
\frac{\hat V_f(s)}{Q(s)}=\frac{50s}{s+50}.$$

El vector resultante es xf = [θ, α, v̂f,θ, v̂f,α]ᵀ. Los ángulos pasan directamente; las velocidades son derivadas filtradas. También aparece un bloque `alpha_dot` con esa transferencia que está desconectado; los canales activos son los construidos con integradores.

## Configuración guardada

| Campo | Valor leído |
|---|---|
| Versión que guardó el archivo | MATLAB/Simulink R2025b Update 2 |
| Solver | ode1, Euler |
| Paso fijo | 0.002 s, equivalente a 500 Hz de actualización nominal |
| Tiempo final | inf |
| Target | quarc_win64.tlc |
| Dependencias del hardware | QUARC Targets y bloques HIL de Quanser |

No se ejecutó el modelo en esta revisión. Abrirlo sin QUARC puede dejar referencias de biblioteca sin resolver. No se encontraron bloques explícitos `Saturation` en los sistemas inspeccionados: confirmar límites y protecciones de la interfaz HIL antes de las pruebas.

## Diferencia con la región de balance solicitada

La función guardada comprueba ±15°. La consigna describe ±10°. La copia descargable preserva el modelo recibido para mantener su trazabilidad; antes de la entrega final debe corregirse el umbral o justificarse la diferencia con el docente. La ganancia de referencia de 15 es un parámetro distinto del umbral de activación.

## Imágenes de alta resolución

El archivo [exportar_diagramas_pendulo.m]({{ '/assets/files/pendulo/exportar_diagramas_pendulo.m' | relative_url }}) exporta la vista principal, la interfaz/planta, la conversión de encoders y el cálculo de estados. Abre el modelo sin iniciar la ejecución física. Requiere MATLAB/Simulink y las bibliotecas del modelo para resolver todos los bloques.

Las imágenes de bloques pueden generarse desde el SLX en MATLAB. Las gráficas de resultados y el video de laboratorio requieren las señales registradas o las evidencias originales; la miniatura y la configuración de un Scope no contienen esas muestras.

Referencia: [MathWorks, exportación programática de diagramas](https://www.mathworks.com/help/simulink/ug/print-from-the-matlab-command-line.html).
