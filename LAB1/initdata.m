% % Called Back from Simulink mdl -> tracking_N
clear all
close all
clc
n13 = 2.5e-3;
n10 = 1.0e-4;
n32 = 2.5e-3;
n0 = 3e-3;
di = 0.35;
Atk = pi/4*di^2;

% I. Model :: SISO
% -------------------------------

A_siso = [-(n13+n10) 0 n13;0 -(n32+n0) n32;n13 n32 -(n13+n32)]/Atk;
B_siso = [7.5e-4 0 0]'/Atk;
C_siso = [0 1 0];
D_siso = [0];

% II. State Feedback Control :: N
% -------------------------------

Ts_design_set = 0.5*399; % << Ts_design_max
Dwn = 3/Ts_design_set;
lambda_1 = -Dwn;
lambda_2 = 5*lambda_1;
lambda_3 = 8*lambda_1;
lambda_spec = [lambda_1 lambda_2 lambda_3]
K = acker(A_siso,B_siso,lambda_spec);
Nxu = [A_siso B_siso;C_siso D_siso]^-1*[zeros(3,1); 1];
N = Nxu(end)+ K*Nxu(1:end-1);



% EFEITO INTEGRAL
clear all
close all
clc
n13 = 4.0e-3;
n10 = 3.0e-4;
n32 = 4.0e-3;
n30 = 3.0e-4;
n0 = 5.0e-3;
di12 = 0.4;
di3 = 0.5;
Atk12 = pi/4*di12^2;
Atk3 = pi/4*di3^2;

% I. Model :: SISO
% -------------------------------

A_siso = [-((n13+n10)/Atk12) 0 (n13/Atk12);0 -((n32+n0)/Atk12) (n32/Atk12);(n13/Atk3) (n32/Atk3) -((n13+n32+n30)/Atk3)];
B_siso = ([(20e-4) 0 0]')/Atk12;
C_siso = [0 1 0];
D_siso = [0];
sys = ss(A_siso,B_siso,C_siso,0);

% II. State Feedback Control :: N
% -------------------------------

A_=[A_siso zeros(3,1); -C_siso 0];
B_ = [B_siso; -D_siso];
C_ = [0 1 0];

Ts_design_set = 399*0.5; % << Ts_design_max
%Ts_design_set = 0.4*422;
Dwn = 3/Ts_design_set;
lambda_1 = -Dwn;
lambda_2 = 5*lambda_1;
lambda_3 = 8*lambda_1;
lambda_4 = 10*lambda_1;
lambda_spec = [lambda_1 lambda_2 lambda_3 lambda_4]
K_ = acker(A_,B_,lambda_spec);
K=K_(1:3);
N=K_(4);












% clear all
% close all
% clc
% n13 = 4.0e-3;
% n10 = 3.0e-4;
% n32 = 4.0e-3;
% n30 = 3.0e-4;
% n0 = 5.0e-3;
% di12 = 0.4;
% di3 = 0.5;
% Atk12 = pi/4*di12^2;
% Atk3 = pi/4*di3^2;
% 
% % I. Model :: SISO
% % -------------------------------
% 
% A_siso = [-((n13+n10)/Atk12) 0 (n13/Atk12);0 -((n32+n0)/Atk12) (n32/Atk12);(n13/Atk3) (n32/Atk3) -((n13+n32+n30)/Atk3)];
% B_siso = ([(20e-4) 0 0]')/Atk12;
% C_siso = [0 1 0];
% D_siso = [0];
% 
% s=ss(A_siso,B_siso,C_siso,D_siso);
% 
% % II. State Feedback Control :: N
% % -------------------------------
% Abar = [A_siso zeros(3,1); -C_siso 0]; Bbar = [B_siso;-D_siso];
% Cbar = [C_siso 0]; Dbar = 0;
% 
% 
% Ts_design_set = 0.4*422; % << Ts_design_max
% Dwn = 3/Ts_design_set;
% lambda_1 = -Dwn;
% lambda_2 = 5*lambda_1;
% lambda_3 = 8*lambda_1;
% lambda_4 = 10*lambda_1;
% lambda_spec_bar = [lambda_1 lambda_2 lambda_3 lambda_4];
% 
% Kbar = acker(Abar,Bbar,lambda_spec_bar);
% K = Kbar(1:3);
% N = Kbar(4);







