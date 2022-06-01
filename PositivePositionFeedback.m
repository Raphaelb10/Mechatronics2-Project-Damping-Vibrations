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
% Cppf3 = 1st order ppf with pole at 5th peak
% Cppf4 = 2nd order ppf tune for 1st peak
% Cppf5 = 1st order ppf with pole at 3rd peak
% Cppf6 = Cppf5 with less gain
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
sisotool(sys(2,2))

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
% bodemag(syscontrolled(1,1))
% hold on
bodemag(syscontrolled5(1,1))
hold on
bodemag(syscontrolled6(1,1))
% legend("openloop","closedloop1","closedloop2","closedloop3")
legend("openloop","Small gain margin","Bigger gain margin")
grid on
%%
rlocus(syscontrolled6(1,1))