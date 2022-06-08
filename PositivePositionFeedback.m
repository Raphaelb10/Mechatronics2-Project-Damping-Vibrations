close all;

sys = open("sys.mat").sys;

%% compliance of the whole syst
close all;
bodemag(sys)
%% Compliance of first pair of patch
bodemag(sys(2,2))
%% Performance index
bodemag(sys(1,1))

%% SISO First order PPF on first patch
% sisotool(sys(2,2));
% Cppf1 = first order ppf
% Cppf2 = 2nd order ppf
% Cppf3 = 1st order ppf with pole at 5th peak
% Cppf4 = 2nd order ppf tune for 1st peak
% Cppf5 = 1st order ppf with pole at 3rd peak
% Cppf6 = Cppf5 with less gain => BEST ONE
% Cppf7 = Cppf3 with less gain, less improvement.
%% SISO - Closing the loop with C1ppf 

syscontrolled=feedback(sys,-Cppf1,2,2);
bodemag(sys(1,1))
hold on
bodemag(syscontrolled(1,1))
legend("openloop","closedloop1")
grid on;

%% SISO Ppf 1st order, pole at the 5th mode
%Cppf3
% sisotool(sys(2,2))

%% Compare siso of cppf1 and 2 and 3

close all;
syscontrolled1=feedback(sys,-Cppf1,2,2);
syscontrolled2=feedback(sys,-Cppf2,2,2); 
syscontrolled3=feedback(sys,-Cppf3,2,2); 
syscontrolled5=feedback(sys,-Cppf5,2,2); 
syscontrolled6=feedback(sys,-Cppf6,2,2); 
syscontrolled7=feedback(sys,-Cppf7,2,2); 

bodemag(sys(1,1))
hold on
bodemag(syscontrolled1(1,1))
hold on
bodemag(syscontrolled3(1,1))
hold on
bodemag(syscontrolled5(1,1))
% legend("openloop","closedloop1","closedloop2","closedloop3")
legend("openloop","Pole at first peak","Pole at 5th peak","Pole at 3rd peak")
grid on
%%%%%%%%%%%%%%%%% MIMO %%%%%%%%%%%%%%%%%%%%%%

%% compliance to select which patch is the best against the 4th mode => the 3rd one.
close all;
for i = 3:6 
    bodemag(sys(i,i))
    hold on 
    grid on
end
legend("Pair 2","Pair 3","Pair 4","Pair 5")
%% Design a ppf 2nd order focused on the 4th mode
sisotool(sys(4,4)); % On the third pair of patches
%CppfMIMO1 tuned on 4th mode using 3rd pair of patches
%%
sysmimo1=feedback(sys,-Cppf6,2,2); %PPF 1st order controller
sysmimo2=feedback(sysmimo1,-CppfMIMO1,4,4);
close all;
bodemag(sys(1,1))
hold on
bodemag(sysmimo1(1,1))
hold on
bodemag(sysmimo2(1,1))

% legend("openloop","closedloop1","closedloop2","closedloop3")
legend("openloop","SISO ppf 1st order","MIMO with ppf 2nd order tuned for mode 4")
grid on
%% Add ppf 2e ordre on patch 4 (i.e sys(5,5))
sisotool(sys(5,5));
%%
BO=sys(4,4)*(-CppfMIMO1);
rlocus(BO);


%%
sysmimo1=feedback(sys,-Cppf6,2,2); %PPF 1st order controller
sysmimo2=feedback(sysmimo1,-CppfMIMO1,4,4);
sysmimo3=feedback(sysmimo2,-CppfMIMO2,5,5);
sysmimo4=feedback(sysmimo3,-CppfMIMO3,5,5);
figure
bodemag(sys(1,1))
hold on
bodemag(sysmimo1(1,1))
hold on
bodemag(sysmimo2(1,1))
hold on
bodemag(sysmimo3(1,1))
hold on
bodemag(sysmimo4(1,1))

legend("openloop","SISO ppf 1st order","MIMO with 1 pair of patches","MIMO with 2 pairs of patches","MIMO with 3 pairs of patches")
grid on
%%
figure
impulse(sys(1,1));
hold on
impulse(sysmimo4(1,1));
legend("Openloop","MIMO with PPF 1st order and 2nd order")
grid on
%%

%% ppf 2e ordre on patch 5
sisotool(sys(6,6))
%% truc d'amaury pour illuster le bug
% sys_real=tf(sys);
% 
% %ppf 1er ordre
% sys2 = tf(sys(2,2));
% pole = -3600;
% max_gain = abs(pole)/dcgain(sys2);
% gain = max_gain*0.99;
% C1 = -gain*tf([1],[1 -pole]);
% % ppf 2e ordre
% wf3 = 2740;
% gain = 1.2788e7;
% damping = 0.05;
% C = -gain*tf([1],[1 2*damping*wf3 wf3^2]);
% 
% sysmimo=feedback(sys_real,C1,2,2); %PPF 1st order controller
% sysmimo=feedback(sysmimo,C,4,4);
% sysmimo=feedback(sysmimo,C,5,5);
% sysmimo=feedback(sysmimo,C,6,6);
% sysmimo=feedback(sysmimo,C,3,3);
% 
% close all;
% bodemag(sys(1,1))
% hold on 
% bodemag(sysmimo(1,1))
% 
% legend("openloop","SISO ppf 1st order","firstmimo","MIMO with 2ppf of second order on mode 4","3rd mimo")
% grid on

