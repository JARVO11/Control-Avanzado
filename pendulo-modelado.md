---
layout: default
title: "Modelado del sistema"
nav_order: 2
permalink: /pendulo-modelado/
parent: "Péndulo Qube-Servo 3"
---


# Modelado del sistema

## 1. Estados y convenciones

Se considera el equilibrio vertical superior. El brazo gira un ángulo θ y el péndulo se desvía un ángulo α respecto de esa vertical:

$$x=\begin{bmatrix}\theta&\alpha&\dot\theta&\dot\alpha\end{bmatrix}^{T},\qquad u=V_m.$$

Los ángulos se expresan en radianes, las velocidades en rad/s y la entrada en voltios. θ = 0 es la referencia del brazo y α = 0 la posición superior. El modelo usa encoders para medir ambos ángulos; las velocidades que realimentan el LQR se obtienen con filtros.

$$y=Cx+Du,\quad C=\begin{bmatrix}1&0&0&0\\0&1&0&0\end{bmatrix},\quad D=\begin{bmatrix}0\\0\end{bmatrix}.$$

C y D se explicitan aquí para representar los ángulos medidos; el script recibido solo calcula A y B.

## 2. Parámetros nominales

Valores del cuadro 2 del PDF y del script recibido; **no son una identificación experimental**.

| Parámetro | Símbolo | Valor | Unidad |
|---|---|---:|---|
| Resistencia de armadura | Rm | 7.5 | Ω |
| Constante de torque | kt | 0.0422 | N·m/A |
| Constante contraelectromotriz | km | 0.0422 | V·s/rad |
| Masa del brazo | mr | 0.095 | kg |
| Longitud del brazo | r | 0.085 | m |
| Inercia del brazo | Jr = mr r²/3 | 2.28791667 × 10⁻⁴ | kg·m² |
| Amortiguamiento del brazo | br | 0.001 | N·m·s/rad |
| Masa del péndulo | mp | 0.024 | kg |
| Longitud del péndulo | Lp | 0.129 | m |
| Centro de masa | l = Lp/2 | 0.0645 | m |
| Inercia del péndulo | Jp = mp Lp²/3 | 1.33128 × 10⁻⁴ | kg·m² |
| Amortiguamiento del péndulo | bp | 0.00005 | N·m·s/rad |
| Gravedad | g | 9.81 | m/s² |

## 3. Del balance mecánico al modelo lineal

Se adopta la convención de signos que produce las matrices de la consigna. Para una aproximación de varilla delgada, defínanse h = mp l r, H = Jr + mp r². Una energía cinética y potencial compatibles con esa convención son:

$$T=\tfrac12(H+J_p\sin^2\alpha)\dot\theta^2+\tfrac12J_p\dot\alpha^2-h\cos\alpha\dot\theta\dot\alpha,\qquad U=m_pgl\cos\alpha.$$

Aplicando las ecuaciones de Euler–Lagrange a θ y α, con torque de motor τ y fricción viscosa:

$$\frac{d}{dt}\frac{\partial(T-U)}{\partial\dot q_i}-\frac{\partial(T-U)}{\partial q_i}=\tau_i.$$

Se obtiene, bajo esta aproximación mecánica:

$$\begin{aligned}
(H+J_p\sin^2\alpha)\ddot\theta-h\cos\alpha\ddot\alpha+2J_p\sin\alpha\cos\alpha\dot\theta\dot\alpha+h\sin\alpha\dot\alpha^2&=\tau-b_r\dot\theta,\\
J_p\ddot\alpha-h\cos\alpha\ddot\theta-J_p\sin\alpha\cos\alpha\dot\theta^2-m_pgl\sin\alpha&=-b_p\dot\alpha.
\end{aligned}$$

Alrededor de α = 0 y velocidades nulas, se usan sin α ≈ α, cos α ≈ 1 y se descartan productos de pequeñas desviaciones. Así:

$$\begin{bmatrix}H&-h\\-h&J_p\end{bmatrix}
\begin{bmatrix}\ddot\theta\\\ddot\alpha\end{bmatrix}
=\begin{bmatrix}\tau-b_r\dot\theta\\m_pgl\alpha-b_p\dot\alpha\end{bmatrix}.$$

El torque eléctrico, despreciando la dinámica de la inductancia de armadura, satisface:

$$i=\frac{V_m-k_m\dot\theta}{R_m},\qquad \tau=k_ti.$$

En los parámetros suministrados kt = km numéricamente. Por ello el script usa km en el término de entrada y km² en el amortiguamiento eléctrico. Si estas constantes se cambian por separado, deben usarse kt y kt km respectivamente.

## 4. Despeje de aceleraciones

El determinante de la matriz de inercia es:

$$J_t=HJ_p-h^2=(J_r+m_pr^2)J_p-m_p^2l^2r^2=3.62296758\times10^{-8}.$$

Aunque la consigna lo denomina inercia total equivalente, Jt tiene unidades de (kg·m²)² por ser un determinante. La inversa es:

$$M^{-1}=\frac{1}{J_t}\begin{bmatrix}J_p&h\\h&H\end{bmatrix}.$$

Multiplicando por el vector de torques y separando cada estado:

$$\begin{aligned}
\ddot\theta&=\frac{m_p^2l^2rg}{J_t}\alpha-\frac{J_p(b_r+k_tk_m/R_m)}{J_t}\dot\theta-\frac{hb_p}{J_t}\dot\alpha+\frac{k_tJ_p}{R_mJ_t}V_m,\\
\ddot\alpha&=\frac{Hm_pgl}{J_t}\alpha-\frac{h(b_r+k_tk_m/R_m)}{J_t}\dot\theta-\frac{Hb_p}{J_t}\dot\alpha+\frac{k_th}{R_mJ_t}V_m.
\end{aligned}$$

## 5. Matrices numéricas

$$\dot x=Ax+Bu,$$

$$A\approx\begin{bmatrix}
0&0&1&0\\0&0&0&1\\0&55.152525&-4.547063&-0.181591\\0&168.580984&-4.494190&-0.555058
\end{bmatrix},\qquad B\approx\begin{bmatrix}0\\0\\20.675506\\20.435093\end{bmatrix}.$$

El polo positivo de A, aproximadamente +12.1485 s⁻¹, confirma la inestabilidad del equilibrio superior en lazo abierto. Los otros polos son 0, −14.2556 y −2.9950 s⁻¹.

$$\operatorname{rango}[B\ AB\ A^2B\ A^3B]=4,\qquad
\operatorname{rango}\begin{bmatrix}C\\CA\\CA^2\\CA^3\end{bmatrix}=4.$$

El modelo nominal es controlable y observable con ambos ángulos medidos. Estos cálculos algebraicos se verificaron independientemente con las mismas matrices; no constituyen una validación física.

## 6. Alcance temporal

El diseño recibido es **continuo**. El archivo Simulink usa integración `ode1` con paso 0.002 s. No se sustituyeron A/B por matrices discretas ni se cambió `lqr` por `dlqr`: documentar un diseño discreto exigiría discretizar y volver a verificar el controlador.
