close all, clear all, clc;
format shortEng
format compact
%%
%Variables
syms s t;
A1 = 0.125; A2 = A1;
A3 = 0.196;
n13 = 4e-3;
n32 = 4e-3;
n0 = 5e-3;
n30 = 3e-4;
n10 = 3e-4;
v1 = 20e-4;
v2 = 20e-4;
%%
%State space representation System

A = [-(1/A1)*(n13+n10) 0 n13/A1;  0 (-1/A2)*(n32+n0) (1/A2)*n32;  (1/A3)*n13 (1/A3)*n32 -(1/A3)*(n13+n30+n32)];
B = [(1/A1)*v1 0; 0 (1/A2)*v2; 0 0];
C = [1 0 0; 0 1 0; 0 n0 0];
D = zeros(3,2);
%%
%forma canonica, matrizes de transformacao e de transicao
[V,D2] = eig(A, 'nobalance', 'vector');
val_prop = diag(D2);
T = V;
Ad = (T^-1) * A * T;
Bd = T^-1 * B;
Cd = C * T;
phid = diag(exp(D2*t));
phiT = T * phid * T^-1; %transicao de estados atraves da matriz de transicao
phiT = vpa(phiT);
%transicao de estados com Transformada de laplace
sia = s * eye(size(A,1),size(A,2)) - A;
phiS = adjoint(sia) / det(sia);
phi = vpa(ilaplace(phiS));
phi = vpa(phi);
%%
%Time response
sys = ss(A,B,C,D);
G = tf(sys);
figure();
step(G);
figure();
impulse(sys);
%%
%Simulação
x0 = [.5 .5 .5];
t = 0:0.05:2000;
u = zeros(length(t),2);
figure();
lsim(sys,u,t,x0)
[y,t,x] = lsim(sys,u,t,x0);
%%
%evolução do vector de estado
V32 = V(3:-1:2,1:3);
V31 = V(3:-1:1, 1:3), [V31(2,:)] = [];
V21 = V(2:-1:1, 1:3);
figure();
subplot(3,1,1), plot(x(:,3), x(:,2)), hold on, qv1 = quiver([0 0 0], [0 0 0], V32(1,:), V32(2,:), 0.5); hold off;
qv1.MaxHeadSize = .2; qv1.LineStyle='--';
title('Plano X2-X3'), ylabel('x3'), xlabel('x2')

subplot(3,1,2), plot(x(:,3), x(:,1)), hold on, qv1 = quiver([0 0 0], [0 0 0], V31(1,:), V31(2,:), 0.5); hold off;
qv1.MaxHeadSize = .2; qv1.LineStyle='--';
title('Plano X1-X3'), ylabel('x3'), xlabel('x1')

subplot(3,1,3), plot(x(:,2), x(:,1)), hold on, qv1 = quiver([0 0 0], [0 0 0], V21(1,:), V21(2,:), 0.5); hold off;
qv1.MaxHeadSize = .2; qv1.LineStyle='--';
title('Plano X1-X2'), ylabel('x2'), xlabel('x1')
