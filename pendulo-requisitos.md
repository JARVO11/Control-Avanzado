---
layout: default
title: "Objetivos del proyecto"
nav_order: 1
permalink: /pendulo-requisitos/
parent: "Péndulo Qube-Servo 3"
---

# Objetivos del proyecto

Nuestro proyecto corresponde al péndulo rotatorio **Qube-Servo 3**. Buscamos mantenerlo cerca de la posición vertical superior mediante un controlador LQR y estimar las velocidades angulares a partir de los ángulos medidos.

[Ver las especificaciones del proyecto]({{ '/assets/files/pendulo/especificaciones_proyecto_control_avanzado.pdf' | relative_url }}).

## Desarrollo del trabajo

| Tema | Trabajo desarrollado |
|---|---|
| Modelo del sistema | Descripción de los estados, ecuaciones de movimiento y modelo lineal alrededor de la vertical superior. |
| Controlador LQR | Elección de Q y R, cálculo de K y revisión de los polos del modelo en lazo cerrado. |
| Observador | Obtención de las ecuaciones, cálculo de L, m y β y análisis del error de estimación. |
| Implementación | Conexión con el Qube-Servo 3, conversión de encoders y formación del vector de estados en Simulink. |
| Pruebas y análisis | Funcionamiento del montaje, ajustes del controlador y discusión de su respuesta ante perturbaciones. |

## Forma de operación

Levantamos manualmente el péndulo hasta acercarlo a la vertical. El control se habilita dentro de una región angular alrededor de esa posición y actúa sobre el motor del brazo para mantener el equilibrio. La práctica se centra en el balance; no utiliza una maniobra automática para levantar el péndulo.

El diseño del LQR se realiza en tiempo continuo. La ejecución en Simulink utiliza un paso fijo de 0.002 s, equivalente a una actualización nominal de 500 Hz.

## Organización

El [modelado]({{ '/pendulo-modelado/' | relative_url }}) establece las ecuaciones que usamos en el [LQR]({{ '/pendulo-lqr/' | relative_url }}). El [observador]({{ '/pendulo-observador/' | relative_url }}) obtiene las velocidades y la [implementación en Simulink]({{ '/pendulo-simulink/' | relative_url }}) reúne estos elementos. Los [resultados]({{ '/pendulo-resultados/' | relative_url }}) presentan la prueba del equipo y nuestras conclusiones.
