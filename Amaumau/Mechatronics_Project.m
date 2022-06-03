clc 
clear
close all 

%% Import SYS

ss = load('sys.mat');
sys = ss.sys;
A = sys.A;
B = sys.B;
C = sys.C;
D = sys.D;

%% Plant model - Familiarize yourself with the model in terms of inputs and ouptuts 
figure
bodemag(sys);

%% Plant model - Compliance (Performance index) 

% Conversion to transfer function
transfcnXF = tf(sys('Xtip','Ftip'));
transfcnXF_C = tf(1 , transfcnXF.Denominator{1, 1});
figure
bodeplot(transfcnXF);

%% Plant model - Open-loop transfer functions from actuators to sensor 

figure(4)
transfcn = tf(sys);
bodeplot(transfcn);
figure(5)
bodemag(transfcn);
for i=1:6
    figure
    for j=1:6
        bodemag(sys(i,j))
        hold on
    end
    legend('Ftip','P1','P2','P3','P4','P5')
    title(['actuators to sensor ' sys.OutputName(i)])
end
        

%% Plant model - what are the differences between the open-loop tf in terms
%                of pole/zero patterns

% Diagonal plots are collocated Paterns

%% Plant model - Which pair(s) of piezoelectric patches would you choose? 
%                And why?

% Vas1 - The closer the patch to the fixed wall the more vibrations, the
% more amplitude

for i=2:6
    subplot(2,3,i-1)
    bodemag(sys(i,i));
    hold on
    bodemag(sys(1,1))
    
end
legend('Ftip to Xtip','Piezo-sensor','Location','EastOutside')

%% SISO Controller - Lead Control
%Design of the controller base on the first pair of piezo-patch
sys2 = tf(sys(2,2));
%gain = 8.391; %obtained with sisotool
gain = 8.391*1e2; %obtained with trials -> better performance 
C = gain*tf([1 407],[1 4210]);
sys_cl = feedback(C*sys2,1);

%Comparison of the bode curve before and after the control
figure
bodemag(sys2)
hold on 
bodemag(sys_cl)
legend('initial system','controller')

%Implementation of the controller in the whole system

real_sys = tf(sys);
real_sys_cl = feedback(real_sys,C,2,2); % 2,2 because only the place of the first piezo patch is controlled
figure
bodemag(real_sys)
hold on
bodemag(real_sys_cl)
legend('initial system','controller')
figure
% Application of the controller on the real system
impulse(real_sys)
hold on
impulse(real_sys_cl)
legend('initial system','controller')

%Comparison of the body curve from Ftip to Xtip before and after the
%control
figure
bodemag(real_sys(1,1))
hold on 
bodemag(real_sys_cl(1,1))
legend('initial system','controller')
% PPF 
% NDF - to get rid of the first 5 modes

%% SISO Controller - Direct Velocity Feedback
figure
C2 = tf([1 0],[1]);
for i = 0:1:6
    g = 10^(i);
    CL = feedback(sys2,g*C2,1,1);
    bodemag(CL)
    hold on 
end
legend('1e0','1e1','1e2','1e3','1e4','1e5','1e6')
%%
real_sys = tf(sys);
C1 = tf([1 0],[1])*1e-1;
real_sys_cl = feedback(real_sys,C1,2,2);

figure
% Application of the controller on the real system
impulse(real_sys)
hold on
impulse(real_sys_cl)
legend('initial system','controller')

figure
bodemag(real_sys)
hold on
bodemag(real_sys_cl)
legend('initial system','controller')

%Comparison of the body curve from Ftip to Xtip before and after the
%control
figure
bodemag(real_sys(1,1))
hold on 
bodemag(real_sys_cl(1,1))
legend('initial system','controller')


%% SISO Controller - PPF 1st order
sys2 = tf(sys(2,2));
pole = -3600;
max_gain = abs(pole)/dcgain(sys2);
gain = max_gain*0.99;
C = -gain*tf([1],[1 -pole]);
real_sys = tf(sys);
real_sys_cl = feedback(real_sys,C,2,2); % 2,2 because only the place of the first piezo patch is controlled
figure
bodemag(real_sys)
hold on
bodemag(real_sys_cl)
legend('initial system','controller')
figure
% Application of the controller on the real system
impulse(real_sys)
hold on
impulse(real_sys_cl)
legend('initial system','controller')

%Comparison of the body curve from Ftip to Xtip before and after the
%control
figure
bodemag(real_sys(1,1))
hold on 
bodemag(real_sys_cl(1,1))
legend('initial system','controller')


%% SISO Controller - PPF 2nd order 1st mode
sys2 = tf(sys(2,2));
wf = 470;
max_gain = (wf^2)/dcgain(sys2)*0.99;
gain = 3.7626e5;
damping = 0.06;
C = -gain*tf([1],[1 2*damping*wf wf^2]);
real_sys = tf(sys);
real_sys_cl = feedback(real_sys,C,2,2); % 2,2 because only the place of the first piezo patch is controlled
figure
bodemag(real_sys)
hold on
bodemag(real_sys_cl)
legend('initial system','controller')
figure
% Application of the controller on the real system
impulse(real_sys)
hold on
impulse(real_sys_cl)
legend('initial system','controller')

%Comparison of the body curve from Ftip to Xtip before and after the
%control
figure
bodemag(real_sys(1,1))
hold on 
bodemag(real_sys_cl(1,1))
legend('initial system','controller')

%% SISO Controller - PPF 2nd order 2nd mode
sys2 = tf(sys(2,2));
wf = 806;
max_gain = (wf^2)/dcgain(sys2)*0.99;
gain = 1.1065e6;
damping = 0.05;
C = -gain*tf([1],[1 2*damping*wf wf^2]);
real_sys = tf(sys);
real_sys_cl = feedback(real_sys,C,2,2); % 2,2 because only the place of the first piezo patch is controlled
figure
bodemag(real_sys)
hold on
bodemag(real_sys_cl)
legend('initial system','controller')
figure
% Application of the controller on the real system
impulse(real_sys)
hold on
impulse(real_sys_cl)
legend('initial system','controller')

%Comparison of the body curve from Ftip to Xtip before and after the
%control
figure
bodemag(real_sys(1,1))
hold on 
bodemag(real_sys_cl(1,1))
legend('initial system','controller')

%% SISO Controller - PPF 2nd order 3rd mode
sys2 = tf(sys(2,2));
wf = 1720;
max_gain = (wf^2)/dcgain(sys2)*0.99;
gain = 5.0431e6;
damping = 0.05;
C = -gain*tf([1],[1 2*damping*wf wf^2]);
real_sys = tf(sys);
real_sys_cl = feedback(real_sys,C,2,2); % 2,2 because only the place of the first piezo patch is controlled
figure
bodemag(real_sys)
hold on
bodemag(real_sys_cl)
legend('initial system','controller')
figure
% Application of the controller on the real system
impulse(real_sys)
hold on
impulse(real_sys_cl)
legend('initial system','controller')

%Comparison of the body curve from Ftip to Xtip before and after the
%control
figure
bodemag(real_sys(1,1))
hold on 
bodemag(real_sys_cl(1,1))
legend('initial system','controller')

%% SISO Controller - PPF 2nd order 4th mode
sys2 = tf(sys(2,2));
wf = 2740;
max_gain = (wf^2)/dcgain(sys2)*0.99;
gain = 1.2788e7;
damping = 0.05;
C = -gain*tf([1],[1 2*damping*wf wf^2]);
real_sys = tf(sys);
real_sys_cl = feedback(real_sys,C,2,2); % 2,2 because only the place of the first piezo patch is controlled
figure
bodemag(real_sys)
hold on
bodemag(real_sys_cl)
legend('initial system','controller')
figure
% Application of the controller on the real system
impulse(real_sys)
hold on
impulse(real_sys_cl)
legend('initial system','controller')

%Comparison of the body curve from Ftip to Xtip before and after the
%control
figure
bodemag(real_sys(1,1))
hold on 
bodemag(real_sys_cl(1,1))
legend('initial system','controller')

%% SISO Controller - PPF 2nd order 5th mode
sys2 = tf(sys(2,2));
wf = 3460;
max_gain = (wf^2)/dcgain(sys2)*0.99;
gain = 2.0391e7;
damping = 0.05;
C = -gain*tf([1],[1 2*damping*wf wf^2]);
real_sys = tf(sys);
real_sys_cl = feedback(real_sys,C,2,2); % 2,2 because only the place of the first piezo patch is controlled
figure
bodemag(real_sys)
hold on
bodemag(real_sys_cl)
legend('initial system','controller')
figure
% Application of the controller on the real system
impulse(real_sys)
hold on
impulse(real_sys_cl)
legend('initial system','controller')

%Comparison of the body curve from Ftip to Xtip before and after the
%control
figure
bodemag(real_sys(1,1))
hold on 
bodemag(real_sys_cl(1,1))
legend('initial system','controller')

%% SISO Controller - PPF 2nd order 1st mode - IS THAT ONE CORRECT? we take the maximum gain and maximum damping without having the same root locus in the course
sys2 = tf(sys(2,2));
wf = 470;
max_gain = (wf^2)/dcgain(sys2)*0.99;
gain = max_gain;
damping = 0.9;
C = -gain*tf([1],[1 2*damping*wf wf^2]);
real_sys = tf(sys);
real_sys_cl = feedback(real_sys,C,2,2); % 2,2 because only the place of the first piezo patch is controlled
figure
bodemag(real_sys)
hold on
bodemag(real_sys_cl)
legend('initial system','controller')
figure
% Application of the controller on the real system
impulse(real_sys)
hold on
impulse(real_sys_cl)
legend('initial system','controller')

%Comparison of the body curve from Ftip to Xtip before and after the
%control
figure
bodemag(real_sys(1,1))
hold on 
bodemag(real_sys_cl(1,1))
legend('initial system','controller')

%% SISO Controller - NDF


%% MIMO decentralised PPF second order
sys2 = tf(sys(2,2));
pole = -3600;
max_gain = abs(pole)/dcgain(sys2);
gain = max_gain*0.99;
C = -gain*tf([1],[1 -pole]);
% real_sys = tf(sys);
real_sys = sys;
real_sys_cl = feedback(real_sys,C,2,2);
real_sys_ppf1order=real_sys_cl;

sys3 = tf(sys(3,3));
wf3 = 2740;
max_gain = (wf3^2)/dcgain(sys3)*0.99;
gain = 1.2788e7;
damping = 0.05;
C = -gain*tf([1],[1 2*damping*wf3 wf3^2]);
real_sys_cl = feedback(real_sys_cl,C,3,3);

sys4 = tf(sys(4,4));
wf4 = 2740;
max_gain = (wf4^2)/dcgain(sys4)*0.99;
gain = 1.2788e7;
damping = 0.05;
C = -gain*tf([1],[1 2*damping*wf4 wf4^2]);
real_sys_cl = feedback(real_sys_cl,C,4,4);

sys5 = tf(sys(5,5));
wf3 = 2740;
max_gain = (wf3^2)/dcgain(sys5)*0.99;
gain = 1.2788e7;
damping = 0.05;
C = -gain*tf([1],[1 2*damping*wf3 wf3^2]);
real_sys_cl = feedback(real_sys_cl,C,5,5);

sys6 = tf(sys(6,6));
wf3 = 2740;
max_gain = (wf3^2)/dcgain(sys6)*0.99;
gain = 1.2788e7;
damping = 0.05;
C = -gain*tf([1],[1 2*damping*wf3 wf3^2]);
real_sys_cl = feedback(real_sys_cl,C,6,6);

% 2,2 because only the place of the first piezo patch is controlled
% figure
% bodemag(real_sys)
% hold on
% bodemag(real_sys_cl)
% legend('initial system','controller')
% figure
% Application of the controller on the real system
% impulse(real_sys)
% hold on
% impulse(real_sys_cl)
% legend('initial system','controller')

%Comparison of the body curve from Ftip to Xtip before and after the
%control
figure
bodemag(real_sys(1,1))
hold on 
bodemag(real_sys_ppf1order(1,1))
hold on
bodemag(real_sys_cl(1,1))
legend('initial system',"siso",'controller')







