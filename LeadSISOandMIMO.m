close all;

sys = open("sys.mat").sys;

in_ID=2;
out_ID=2;
perf_ID=1;
%% compliance
close all;
% bodemag(sys)
% bodemag(sys(2,2))
bodemag(sys(1,1))
%% Siso Controller 
% a) first colocated pair

sisotool(sys(2,2)) 
% C1 designed to damp the first mode with first pair of patches.
% C2 designed to damp the 5th mode with first pair of patches.

%% MIMO - C designed for Vs1 and Va1, to damp first oscillation, applied on all the states as MIMO decentralized. Surprizingly quite okay results
close all;

syscontrolled=feedback(sys,C1,2,2);

syscontrolled=feedback(syscontrolled,C1,3,3);

syscontrolled=feedback(syscontrolled,C1,4,4);

syscontrolled=feedback(syscontrolled,C1,5,5);

syscontrolled=feedback(syscontrolled,C1,6,6);

bodemag(sys)
hold on
bodemag(syscontrolled)
legend("openloop","closedloop")

figure
impulse(sys(1,1))
hold on
impulse(syscontrolled(1,1))
legend("openloop","closedloop")

figure
bodemag(sys(1,1))
hold on
bodemag(syscontrolled(1,1))
legend("openloop","closedloop")

%% Compare bode plots between Vs1/Va1 and Vs3/Va3
close all;
bodemag(sys(2,2))
hold on
bodemag(sys(4,4))
%% Design controller for Vs3/Va3
sisotool(sys(4,4))
%C3 designed to damp 5th mode with 3rd pair of actuators.

%% SISO - Comparaison of the 2 controller designed for 1st pair, and the controller designed for 3rd pair. 
close all;

syscontrolled1=feedback(sys,C1,2,2);
syscontrolled2=feedback(sys,C2,2,2); 
syscontrolled3=feedback(sys,C3,4,4);

bodemag(sys(1,1))
hold on
bodemag(syscontrolled1(1,1))
hold on
bodemag(syscontrolled2(1,1))
hold on
bodemag(syscontrolled3(1,1))
legend("openloop","closedloop1","closedloop2","3")

%% MIMO - Closing the loop with C1 and C3 togheter
syscontrolled=feedback(sys,C1,2,2);
syscontrolled=feedback(syscontrolled,C3,4,4);
bodemag(sys(1,1))
hold on
bodemag(syscontrolled(1,1))
legend("openloop","closedloop1")
%% Compare bode plots between Vs1/Va1 and Vs4/Va4
close all;
bodemag(sys(2,2))
hold on
bodemag(sys(5,5))
%% Design controller for Vs4/Va4
sisotool(sys(5,5))
%C4 designed for 3rd mode, using 4th pair of patches
%% SISO C4 - Bode plots of the closeloop with C4 (alone), and the system open loop.
syscontrolled=feedback(sys,C4,4,4);
bodemag(sys(1,1))
hold on
bodemag(syscontrolled(1,1))
legend("openloop","closedloop1")
%% MIMO - Adding C4 to the other previously designed controller, and comparison with openloop.
close all;
syscontrolled=feedback(sys,C1,2,2);
syscontrolled=feedback(syscontrolled,C3,4,4);
syscontrolled=feedback(syscontrolled,C4,5,5);

bodemag(sys(1,1))
hold on
bodemag(syscontrolled(1,1))
legend("openloop","closedloop1")

%% Compare bode plots of the two remaining patches to see which one can damp the remaning peaks.
close all;
bodemag(sys(2,2))
hold on
bodemag(sys(3,3))
hold on
bodemag(sys(6,6))
legend()
%% Design controller for last patch Vs5/Va5
sisotool(sys(6,6)) 
%C5 aiming at 2nd and 3rd peak
%% See impact of C5 compared to open loop system
syscontrolled=feedback(sys,C5,6,6);
bodemag(sys(1,1))
hold on
bodemag(syscontrolled(1,1))
legend("openloop","closedloop1")
%% MIMO - Adding C5 to the rest of the previously designed controllers
close all;
syscontrolled=feedback(sys,C1,2,2);
syscontrolled=feedback(syscontrolled,C3,4,4);
syscontrolled=feedback(syscontrolled,C4,5,5);
syscontrolled=feedback(syscontrolled,C5,6,6);
figure
impulse(sys(1,1))
hold on
impulse(syscontrolled(1,1))

figure
bodemag(sys(1,1))
hold on
bodemag(syscontrolled(1,1))
legend("openloop","closedloop1")

%% See if the remaining patch is usefull, not too much so don't use it in this mimo decentralized.
close all;
bodemag(sys(2,2))
hold on
bodemag(sys(3,3))
legend()