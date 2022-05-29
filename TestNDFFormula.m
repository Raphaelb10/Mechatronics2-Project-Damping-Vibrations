clear all;clc;close all;

%Flag H2 optimization method, Hinifinity if = 0
H2 = 0;

% Controller parameters to find
Kc = sdpvar(1,1);
XiC = sdpvar(1,1);
alpha = sdpvar(1,1);

F = [];
w = sdpvar(1,1);
XiEq = sdpvar(1,1);

%System Variables

%system gain
g0 = 0;

%zero to take into account
wz = 0;
XiZ = 0;

%pole to take into account
wp = 0;
XiP = 0;

F = [F ];
F = [F ];

%Based on Maximum Damping Method

F = [F XiEq == 2*XiF^2-2*XiP*XiC-XiZ*gamma*Kc*g0];
F = [F alpha == (XiEq+1)+sign(alpha-1)*sqrt(XiEq^2+2*XiEq)];
F = [F XiC == ((2*XiF*sqrt(alpha)-XiP)*(1-gamma^2)-(1-alpha)*(2*XiF*sqrt(alpha)-XiP*(1+alpha)))/(alpha*(1-gamma^2))];
F = [F Kc == (2*(1-alpha)*(2*XiF*sqrt(alpha)-XiP*(1+alpha)))/(g0*alpha*(1-gamma^2))];

%Cost function
closedSystem = sqrt(((wz^2-w^2)^2+(2*XiZ*wz*w)^2)/((w^4-(wp^2+wc^2+2*XiZ*wc*Kc*wc*g0)*w^2+wp^2*wc^2)^2+(-w^3*(2*XiP*wp+2*XiC*wc+g0*Kc*wc)+(2*XiP*wp*wc^2+2*XiC*wc*wp^2+g0*wz^2*Kc*wc)*w)^2));

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
XiC = double(XiC);
alpha = double(alpha);

w0 = alpha*wp;