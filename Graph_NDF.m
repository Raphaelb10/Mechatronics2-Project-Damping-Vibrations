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

resolution = 1000;%nb of points

KcMax = 10000;


Kc = 1/KcMax : KcMax/resolution : KcMax;
XiC = 0: 1/resolution:1;
w = 1 : 10e5/resolution : 10e5;


%System Variables

sysPatchConsidered = sys(patchConsidered(1),patchConsidered(2));
tfPatch = tf(sysPatchConsidered);
[Z,gain] = zero(tfPatch);
P = pole(tfPatch);
[rsys,info] = balred(sysPatchConsidered,2);

%maybe add static comp of other modes to gain

% [tempnum,tempdenum] = zp2tf([Z(end-2*(modeToDamp-1));Z(end-(2*(modeToDamp-1)+1))],[P(end-2*(modeToDamp-1));Z(end-(2*(modeToDamp-1)+1))],gain);
% troncatedtf = tf(tempnum,tempdenum);
% 
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

gamma = wz/wp;

wc = wp;
Kc = 1;
    for j = 1: length(XiC)
        closedSystem(j) = sqrt(((wz^2-wp^2)^2+(2*XiZ*wz*wp)^2)/((wp^4-(wp^2+wc^2+2*XiZ*wc*Kc*wc*g0)*wp^2+wp^2*wc^2)^2+(-wp^3*(2*XiP*wp+2*XiC(j)*wc+g0*Kc*wc)+(2*XiP*wp*wc^2+2*XiC(j)*wc*wp^2+g0*wz^2*Kc*wc)*wp)^2));
    end

plot(XiC,closedSystem)

