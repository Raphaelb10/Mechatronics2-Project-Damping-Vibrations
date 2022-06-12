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
figure
bodemag(sys(perf_index(1),perf_index(2)))

%% Each piezo impact separatly
figure
bodemag(sys(first_patch(1),first_patch(2)))
figure
bodemag(sys(second_patch(1),second_patch(2)))
figure
bodemag(sys(third_patch(1),third_patch(2)))
figure
bodemag(sys(fourth_patch(1),fourth_patch(2)))
figure
bodemag(sys(fifth_patch(1),fifth_patch(2)))

%% Each piezo impact comparaison

figure
bodemag(sys(first_patch(1),first_patch(2)))
hold on
bodemag(sys(second_patch(1),second_patch(2)))
hold on
bodemag(sys(third_patch(1),third_patch(2)))
hold on
bodemag(sys(fourth_patch(1),fourth_patch(2)))
hold on
bodemag(sys(fifth_patch(1),fifth_patch(2)))

legend

%%
sisotool(sys(fifth_patch(1),fifth_patch(2))) %Taper dans le 2e mode en lead

%% Hybrid MIMO PPF/Lead

load('Cppf6.mat')
syscontrolled=feedback(sys,Cppf6,first_patch(1),first_patch(2),1);

figure
bodemag(sys(perf_index(1),perf_index(2)))
hold on
bodemag(syscontrolled(perf_index(1),perf_index(2)))
hold on

syscontrolled=feedback(syscontrolled,CLP5M2,fifth_patch(1),fifth_patch(2));
bodemag(syscontrolled(perf_index(1),perf_index(2)))
hold on

legend('Undamped system', 'PPF 1st order', 'PPF 1st order + Lead on 2nd mode')

