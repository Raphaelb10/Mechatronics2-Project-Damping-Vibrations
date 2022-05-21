close all;

sys = open("sys.mat").sys;

in_ID=2;
out_ID=2;
perf_ID=1;
%% compliance of the whole syst
close all;
bodemag(sys)
%% Compliance of first pair of patch
bodemag(sys(2,2))
%% Performance index
bodemag(sys(1,1))

%% SISO First order PPF on first patch
sisotool(sys(2,2));