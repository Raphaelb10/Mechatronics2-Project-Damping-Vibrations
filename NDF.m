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

%% Sisotool first patch

sisotool(sys(first_patch(1),first_patch(2)))

%% Sisotool fifth patch

sisotool(sys(fifth_patch(1),fifth_patch(2)))

%% Damping evaluation SISO

syscontrolled1=feedback(sys,Cndf1,first_patch(1),first_patch(2),1);
syscontrolled2 = feedback(sys,Cndf2,fifth_patch(1),fifth_patch(2));

figure
bodemag(sys(perf_index(1),perf_index(2)))
hold on
bodemag(syscontrolled1(perf_index(1),perf_index(2)))
hold on
bodemag(syscontrolled2(perf_index(1),perf_index(2)))
legend('no control','NDF first peak', 'NDF second peak')

%% Damping evaluation MIMO

syscontrolled1=feedback(sys,Cndf1,first_patch(1),first_patch(2),1);
syscontrolled1 = feedback(syscontrolled1,Cndf2,fifth_patch(1),fifth_patch(2));

figure
bodemag(sys(perf_index(1),perf_index(2)))
hold on
bodemag(syscontrolled1(perf_index(1),perf_index(2)))
legend('no control','NDF')
