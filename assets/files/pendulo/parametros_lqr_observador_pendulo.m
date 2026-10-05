%% Qube-Servo 3: parametros, LQR continuo y observador de la consigna
% Adaptacion comentada de ProyectoControlDinal.m.
% Conserva parametros, pesos y ganancias; no ejecuta el hardware.
% Estados: x = [theta; alpha; theta_dot; alpha_dot], rad y rad/s.
% Entrada u: voltaje equivalente del motor (V).
% Requiere Control System Toolbox. No requiere variables simbolicas.
clc;
clear;

%% 1. Parametros nominales del motor, brazo y pendulo
Rm = 7.5;                 % Resistencia de armadura (ohm)
kt = 0.0422;              % Constante de torque (N*m/A)
km = 0.0422;              % Constante contraelectromotriz (V*s/rad)
mr = 0.095;               % Masa del brazo (kg)
r = 0.085;                % Longitud del brazo (m)
Jr = mr*r^2/3;            % Inercia del brazo (kg*m^2)
br = 1e-3;                % Friccion viscosa del brazo (N*m*s/rad)
mp = 0.024;               % Masa del pendulo (kg)
Lp = 0.129;               % Longitud total del pendulo (m)
l_cm = Lp/2;              % Centro de masa (m); distinto de ganancia L
Jp = mp*Lp^2/3;           % Inercia del pendulo respecto al pivote
bp = 5e-5;                % Friccion viscosa del pendulo
g = 9.81;                % Gravedad (m/s^2)
Jt = (Jr + mp*r^2)*Jp - mp^2*l_cm^2*r^2;

%% 2. Modelo continuo alrededor de la vertical superior
% Se mantiene la expresion del original: kt = km en estos parametros.
% Si se cambian por separado, reemplazar km^2 por kt*km y km por kt
% en los terminos de actuacion B3 y B4.
A32 = mp^2*l_cm^2*r*g/Jt;
A33 = -br*Jp/Jt - km^2*Jp/(Rm*Jt);
A34 = -mp*l_cm*r*bp/Jt;
A42 = mp*g*l_cm*(Jr+mp*r^2)/Jt;
A43 = -mp*l_cm*r*br/Jt - km^2*mp*l_cm*r/(Rm*Jt);
A44 = -(Jr+mp*r^2)*bp/Jt;
B3 = km*Jp/(Rm*Jt);
B4 = km*mp*l_cm*r/(Rm*Jt);
A = [0 0 1 0; 0 0 0 1; 0 A32 A33 A34; 0 A42 A43 A44];
B = [0; 0; B3; B4];
C = [1 0 0 0; 0 1 0 0]; % Angulos medidos
D = zeros(2,1);

%% 3. LQR continuo: mismos pesos que el archivo recibido
Q = diag([1 20 0.1 0.1]);
R = 10;
[K,P,polosLQR] = lqr(A,B,Q,R);
rangoControlabilidad = rank(ctrb(A,B));
rangoObservabilidad = rank(obsv(A,C));

%% 4. Observador de salida: ganancias por igualdad de coeficientes
% eta = [q_estimado; velocidad_estimada; z]
% eta_dot = Aobs*eta + Bobs*q_medido
% det(sI-Aobs) = s^3 + beta*s^2 + L*s + L*beta + m
a = 100;
beta = 3*a;
L = 3*a^2;
m = a^3 - L*beta;
Aobs = [0 1 0; -L 0 m; -1 0 -beta];
Bobs = [0; L; 1];         % Numerica; evita conservar Bobs simbolica
polinomioDeseado = [1 3*a 3*a^2 a^3];
polinomioObservador = [1 beta L L*beta+m];
polosObservador = eig(Aobs);

%% 5. Resultados de diseno; no son registros del equipo fisico
disp('A ='); disp(A);
disp('B ='); disp(B);
disp('K ='); disp(K);
disp('Polos nominales del LQR:'); disp(polosLQR);
disp('Rangos [controlabilidad observabilidad]:');
disp([rangoControlabilidad rangoObservabilidad]);
disp('Ganancias [L m beta]:'); disp([L m beta]);
disp('Polinomio del observador:'); disp(polinomioObservador);
disp('Polos del observador (raiz triple numericamente sensible):');
disp(polosObservador);
% PENDIENTE EN EL SLX RECIBIDO:
% - Conectar medicion al observador y sus estimaciones al control.
% - Implementar el segundo canal si se observan ambos angulos.
% - Resolver diferencia entre activacion +/-15 grados y PDF +/-10.
% - Registrar pruebas, errores, voltajes y video de laboratorio.
