close all
clear all
clc;
format shortEng
format compact
%%
%Variables
syms s t L0 lambda w u y;


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

% A = [-(1/A1)*(n13+n10) 0 n13/A1;  0 (-1/A2)*(n32+n0) (1/A2)*n32;  (1/A3)*n13 (1/A3)*n32 -(1/A3)*(n13+n30+n32)];
% B = [(1/A1)*v1 0; 0 (1/A2)*v2; 0 0];
A=[-0.342 0 0.0318; 0 -0.0716 0.0318; 0.0204 0.0204 -0.0423];
B=[0.159 0; 0 0.159; 0 0];
C = [1 0 0; 0 1 0];
D = zeros(2,2);
%% 
%controlabilidade e observabilidade

[V,D2] = eig(A, 'nobalance', 'vector');
val_prop = diag(D2);
T = V;
Ad = (T^-1) * A * T;
Bd = T^-1 * B;
Cd = C * T;
% sys=ss(Ad,Bd,Cd,0);
%%
%%%%%%%%%%%%%%%%%%%%%%%%CONTROLO%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
A_=[A zeros(3,2); -C zeros(2,2)];
B_=[B;-D];
C_=[C zeros(2,2)];

Ts_design_set = 220;
Wn = 4.6/Ts_design_set;
%D=0.826;
%D=.5;
%D=abs(log(1/100)/(sqrt((pi^2)+log(1/100)^2)));
%lambda_1 = -D*Wn+1i*Wn*sqrt(1-D^2);
%2 2.5 4
lambda_1 = -0.0209 + j*0.0143;
lambda_2 = conj(lambda_1);
lambda_3 = 2*real(lambda_1);
lambda_4 = 2.5*real(lambda_1);
lambda_5= 4*real(lambda_1);
lambda_spec = [lambda_1 lambda_2 lambda_3 lambda_4 lambda_5]
%lambda_spec=[lambda_1 lambda_2 -.0419 -.0628 -.1047];
%lambda_spec=[lambda_1 lambda_2 -.0455 -.0690 -.1150];
K_ = place(A_,B_,lambda_spec);
K=K_(:,1:3);
N=K_(:,4:end);
CLS= A_-B_*K_;
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%OBSERVADOR%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Wn0 = 4.6/50;
lambda_spec_=[-Wn0 -1.1*Wn0 -1.2*Wn0];
%lambda_spec_=[-0.0003349 -0.000628 -0.000669];
%lambda_spec_=[8*lambda_5 15*lambda_5 16*lambda_5];
L=place(A',C',lambda_spec_);
L=L';
A_obs=A-(L*C);
B_obs=[B L];

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%OBSERVADOR DE ORDEM MINIMA%%%%%%%%%%%%%%%%
A1m=A(1:2,1:2)
A10=A(1:2,3)
A2m=A(3,1:2)
A20=A(3,3)
%A0=A20-L0*A10;
Bm=B(1:2,1:2)
B0=B(3,:)
Cm=C(1:2,1:2)
C0=C(:,3)
L_min=place(A20',A10',-Wn0)'
%L=2;
F=A20-L_min*A10
G=(A20-L_min*A10)*L_min + (A2m-L_min*A1m)
%G=inv(Cm) * (A2m - L*Cm*A1m + F*L*Cm)
H=B0-L_min*Bm














