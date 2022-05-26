%% Open stuff

close all;

sys = open("sys.mat").sys;

perf_index = [1,1];

%% Compliance of the whole unchanged system

bodemag(sys)

%% Perfomance index

bodemag(sys(perf_index(1),perf_index(2)))

