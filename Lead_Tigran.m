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

%% Sisotool damp first mode on first patch

% sisotool(sys(first_patch(1),first_patch(2)))

%% Sisotool damp 2nd mode on 5th patch

% sisotool(sys(fifth_patch(1),fifth_patch(2)))

%% Sisotool damp 3rd mode 4th patch

% sisotool(sys(fourth_patch(1),fourth_patch(2)))

%% Sisotool damp 2nd mode 2nd patch

% sisotool(sys(second_patch(1),second_patch(2)))

%% Sisotool damp 5th mode 3rd patch

% sisotool(sys(third_patch(1),third_patch(2)))

%% Lazy MIMO controller
load('CLP1M1.mat')

syssisocontrolled=feedback(sys,CLP1M1,first_patch(1),first_patch(2));

syscontrolled=feedback(syssisocontrolled,CLP1M1,second_patch(1),second_patch(2));

syscontrolled=feedback(syscontrolled,CLP1M1,third_patch(1),third_patch(2));

syscontrolled=feedback(syscontrolled,CLP1M1,fourth_patch(1),fourth_patch(2));

syscontrolled=feedback(syscontrolled,CLP1M1,fifth_patch(1),fifth_patch(2));

figure
bodemag(sys(perf_index(1),perf_index(2)))
hold on
bodemag(syssisocontrolled(perf_index(1),perf_index(2)))
hold on
bodemag(syscontrolled(perf_index(1),perf_index(2)))

legend('Undamped system', 'Siso Lead CLP1M1', 'Lazy MIMO Lead')

%% MIMO controller 
load('CLP1M1.mat')
load('CLP5M2.mat')
load('CLP4M3.mat')
load('CLP2M2.mat')
load('CLP3M5.mat')

syscontrolled2=feedback(sys,CLP1M1,first_patch(1),first_patch(2));

syscontrolled2=feedback(syscontrolled2,CLP2M2,second_patch(1),second_patch(2));

syscontrolled2=feedback(syscontrolled2,CLP3M5,third_patch(1),third_patch(2));

syscontrolled2=feedback(syscontrolled2,CLP4M3,fourth_patch(1),fourth_patch(2));

syscontrolled2=feedback(syscontrolled2,CLP5M2,fifth_patch(1),fifth_patch(2));

figure
bodemag(sys(perf_index(1),perf_index(2)))
hold on
bodemag(syscontrolled(perf_index(1),perf_index(2)))
hold on
bodemag(syscontrolled2(perf_index(1),perf_index(2)))

legend('Undamped system', 'Lazy MIMO Lead','MIMO Lead')

