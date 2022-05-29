clear all;clc;close all;

sys = open("sys.mat").sys;

perf_index = [1,1];
first_patch = [2,2];
second_patch = [3,3];
third_patch = [4,4];
fourth_patch = [5,5];
fifth_patch = [6,6];

patchConsidered = first_patch;
modeToDamp = 1;

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

sysPatchConsidered = sys(patchConsidered(1),patchConsidered(2));
tfPatch = tf(sysPatchConsidered);
[Z,gain] = zero(tfPatch);
P = pole(tfPatch);
[rsys,info] = balred(sysPatchConsidered,2);

%maybe add static comp of other modes to gain

% [tempnum,tempdenum] = zp2tf([Z(end-2*(modeToDamp-1));Z(end-(2*(modeToDamp-1)+1))],[P(end-2*(modeToDamp-1));Z(end-(2*(modeToDamp-1)+1))],gain);
% troncatedtf = tf(tempnum,tempdenum);

% figure 
% bodemag(tfPatch)
% hold on
% bodemag(troncatedtf)
% hold on 
% bodemag(rsys)

%system gain
g0 = gain;

%zero to take into account
zerotaken = Z(end-2*(modeToDamp-1));
wz = abs(zerotaken);
XiZ = -cos(angle(zerotaken));

%pole to take into account
poletaken = P(end-2*(modeToDamp-1));
wp = abs(poletaken);
XiP = -cos(angle(poletaken));


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