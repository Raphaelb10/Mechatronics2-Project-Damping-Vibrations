clear all;clc;close all;

%Flag H2 optimization method, Hinifinity if = 0
H2 = 0;

% Controller parameters to find
Kc = sdpvar(1,1);
EtaC = sdpvar(1,1);
alpha = sdpvar(1,1);

F = [];
w = sdpvar(1,1);
EtaEq = sdpvar(1,1);

%System Variables

%system gain
g0 = 0;

%zero to take into account
wz = 0;
EtaZ = 0;

%pole to take into account
wp = 0;
EtaP = 0;

F = [F ];
F = [F ];

%Based on Maximum Damping Method

F = [F EtaEq == 2*EtaF^2-2*EtaP*EtaC-EtaZ*gamma*Kc*g0];
F = [F alpha == (EtaEq+1)+sign(alpha-1)*sqrt(EtaEq^2+2*EtaEq)];
F = [F EtaC == ((2*EtaF*sqrt(alpha)-EtaP)*(1-gamma^2)-(1-alpha)*(2*EtaF*sqrt(alpha)-EtaP*(1+alpha)))/(alpha*(1-gamma^2))];
F = [F Kc == (2*(1-alpha)*(2*EtaF*sqrt(alpha)-EtaP*(1+alpha)))/(g0*alpha*(1-gamma^2))];

%Cost function
closedSystem = sqrt(((wz^2-w^2)^2+(2*EtaZ*wz*w)^2)/((w^4-(wp^2+wc^2+2*EtaZ*wc*Kc*wc*g0)*w^2+wp^2*wc^2)^2+(-w^3*(2*EtaP*wp+2*EtaC*wc+g0*Kc*wc)+(2*EtaP*wp*wc^2+2*EtaC*wc*wp^2+g0*wz^2*Kc*wc)*w)^2));

if H2 == 1
funH2 = 0;
fun = funH2;
else
funHinfinity = closedSystem;
fun = funHinfinity;
F = [F w==wp];
end

% Minimise H2
optimize(F,fun)

% Final values

Kc = double(Kc);
EtaC = double(EtaC);
alpha = double(alpha);

w0 = alpha*wp;