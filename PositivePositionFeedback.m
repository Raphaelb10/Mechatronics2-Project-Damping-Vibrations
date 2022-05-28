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
sisotool(sys(2,2));
% Cppf1 = first order ppf
% Cppf2 = 2nd order ppf
%Cppf3 = ??? badly tuned for 2nd peak
%% SISO - Closing the loop with C1ppf 

syscontrolled=feedback(sys,-Cppf1,2,2);
bodemag(sys(1,1))
hold on
bodemag(syscontrolled(1,1))
legend("openloop","closedloop1")
grid on;
%% Compare siso of cppf1 and 2
close all;
syscontrolled1=feedback(sys,-Cppf1,2,2);
syscontrolled2=feedback(sys,-Cppf2,2,2); 
bodemag(sys(1,1))
hold on
bodemag(syscontrolled1(1,1))
hold on
bodemag(syscontrolled2(1,1))
legend("openloop","closedloop1","closedloop2","3")


