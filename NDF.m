%% Open stuff

close all;

sys = open("sys.mat").sys;

perf_index = [1,1];
first_patch = [2,2];
second_patch = [3,3];
third_patch = [4,4];
fourth_patch = [5,5];
fifth_patch = [6,6];

%% Compliance of the whole unchanged system

bodemag(sys)

%% Perfomance index

bodemag(sys(perf_index(1),perf_index(2)))

%% Sisotool first patch

sisotool(sys(first_patch(1),first_patch(2)))

