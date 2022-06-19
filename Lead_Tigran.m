%% Open stuff

close all;

sys = open("sys.mat").sys;

perf_index = [1,1];
first_patch = [2,2];
second_patch = [3,3];
third_patch = [4,4];
fourth_patch = [5,5];
fifth_patch = [6,6];

Linewidth = 2;
FontSize = 15;

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
Fh = gcf;                                                   % Handle To Current Figure
Kids = Fh.Children;                                         % Children
AxAll = findobj(Kids,'Type','Axes');                        % Handles To Axes
Ax1 = AxAll(1);                                             % First Set Of Axes
LinesAx1 = findobj(Ax1,'Type','Line');                      % Handle To Lines
LinesAx1(2).LineWidth = Linewidth;                                  % Set ‘LineWidth’
Ax2 = AxAll(2);                                             % Second Set Of Axes
LinesAx2 = findobj(Ax2,'Type','Line');                      % Handle To Lines
LinesAx2(2).LineWidth = Linewidth;                                  % Set ‘LineWidth’

hold on
bodemag(sys(second_patch(1),second_patch(2)))
Fh = gcf;                                                   % Handle To Current Figure
Kids = Fh.Children;                                         % Children
AxAll = findobj(Kids,'Type','Axes');                        % Handles To Axes
Ax1 = AxAll(1);                                             % First Set Of Axes
LinesAx1 = findobj(Ax1,'Type','Line');                      % Handle To Lines
LinesAx1(2).LineWidth = Linewidth;                                  % Set ‘LineWidth’
Ax2 = AxAll(2);                                             % Second Set Of Axes
LinesAx2 = findobj(Ax2,'Type','Line');                      % Handle To Lines
LinesAx2(2).LineWidth = Linewidth;                                  % Set ‘LineWidth’


hold on
bodemag(sys(third_patch(1),third_patch(2)))
Fh = gcf;                                                   % Handle To Current Figure
Kids = Fh.Children;                                         % Children
AxAll = findobj(Kids,'Type','Axes');                        % Handles To Axes
Ax1 = AxAll(1);                                             % First Set Of Axes
LinesAx1 = findobj(Ax1,'Type','Line');                      % Handle To Lines
LinesAx1(2).LineWidth = Linewidth;                                  % Set ‘LineWidth’
Ax2 = AxAll(2);                                             % Second Set Of Axes
LinesAx2 = findobj(Ax2,'Type','Line');                      % Handle To Lines
LinesAx2(2).LineWidth = Linewidth;                                  % Set ‘LineWidth’


hold on
bodemag(sys(fourth_patch(1),fourth_patch(2)))
Fh = gcf;                                                   % Handle To Current Figure
Kids = Fh.Children;                                         % Children
AxAll = findobj(Kids,'Type','Axes');                        % Handles To Axes
Ax1 = AxAll(1);                                             % First Set Of Axes
LinesAx1 = findobj(Ax1,'Type','Line');                      % Handle To Lines
LinesAx1(2).LineWidth = Linewidth;                                  % Set ‘LineWidth’
Ax2 = AxAll(2);                                             % Second Set Of Axes
LinesAx2 = findobj(Ax2,'Type','Line');                      % Handle To Lines
LinesAx2(2).LineWidth = Linewidth;                                  % Set ‘LineWidth’


hold on
bodemag(sys(fifth_patch(1),fifth_patch(2)))
Fh = gcf;                                                   % Handle To Current Figure
Kids = Fh.Children;                                         % Children
AxAll = findobj(Kids,'Type','Axes');                        % Handles To Axes
Ax1 = AxAll(1);                                             % First Set Of Axes
LinesAx1 = findobj(Ax1,'Type','Line');                      % Handle To Lines
LinesAx1(2).LineWidth = Linewidth;                                  % Set ‘LineWidth’
Ax2 = AxAll(2);                                             % Second Set Of Axes
LinesAx2 = findobj(Ax2,'Type','Line');                      % Handle To Lines
LinesAx2(2).LineWidth = Linewidth;                                  % Set ‘LineWidth’


title('Bode diagram of the colocated pairs of patch' ,'FontSize', FontSize);

xlabel( 'Frequency (Hz)', 'FontSize', FontSize);
ylabel( 'Magnitude (dB)','FontSize', FontSize);

[hleg1, hobj1] = legend('Pair 1','Pair 2','Pair 3','Pair 4','Pair 5');
set(hleg1,'position',[0 0 0.5 0.5])
textobj = findobj(hobj1, 'type', 'text');
set(textobj, 'Interpreter', 'latex', 'fontsize', FontSize);


ha = get(gca,'title');
ha.String = 'From : Vai To : Vsi'; % remove the subtitle "From: u1 To: y1"


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

%% Siso controllers
load('CLP1M1.mat')
load('CDVFP1M1.mat')
load('CLP1MA.mat')
Linewidth = 2;

syssisocontrolled1=feedback(sys,CDVFP1M1,first_patch(1),first_patch(2));
syssisocontrolled2=feedback(sys,CLP1M1,first_patch(1),first_patch(2));
syssisocontrolled3=feedback(sys,CLP1MA,first_patch(1),first_patch(2));

opts = bodeoptions('cstprefs');
opts.PhaseVisible = 'off';
% opts.FreqUnits = 'Hz';

% h = bodeplot(tf(1,[1,1]),opts);

figure
bodemag(sys(perf_index(1),perf_index(2)),opts)
Fh = gcf;                                                   % Handle To Current Figure
Kids = Fh.Children;                                         % Children
AxAll = findobj(Kids,'Type','Axes');                        % Handles To Axes
Ax1 = AxAll(1);                                             % First Set Of Axes
LinesAx1 = findobj(Ax1,'Type','Line');                      % Handle To Lines
LinesAx1(2).LineWidth = Linewidth;                                  % Set ‘LineWidth’
Ax2 = AxAll(2);                                             % Second Set Of Axes
LinesAx2 = findobj(Ax2,'Type','Line');                      % Handle To Lines
LinesAx2(2).LineWidth = Linewidth;                                  % Set ‘LineWidth’
hold on
bodemag(syssisocontrolled1(perf_index(1),perf_index(2)))
Fh = gcf;                                                   % Handle To Current Figure
Kids = Fh.Children;                                         % Children
AxAll = findobj(Kids,'Type','Axes');                        % Handles To Axes
Ax1 = AxAll(1);                                             % First Set Of Axes
LinesAx1 = findobj(Ax1,'Type','Line');                      % Handle To Lines
LinesAx1(2).LineWidth = Linewidth;                                  % Set ‘LineWidth’
Ax2 = AxAll(2);                                             % Second Set Of Axes
LinesAx2 = findobj(Ax2,'Type','Line');                      % Handle To Lines
LinesAx2(2).LineWidth = Linewidth;                                  % Set ‘LineWidth’
hold on
bodemag(syssisocontrolled2(perf_index(1),perf_index(2)))
grid
Fh = gcf;                                                   % Handle To Current Figure
Kids = Fh.Children;                                         % Children
AxAll = findobj(Kids,'Type','Axes');                        % Handles To Axes
Ax1 = AxAll(1);                                             % First Set Of Axes
LinesAx1 = findobj(Ax1,'Type','Line');                      % Handle To Lines
LinesAx1(2).LineWidth = Linewidth;                                  % Set ‘LineWidth’
Ax2 = AxAll(2);                                             % Second Set Of Axes
LinesAx2 = findobj(Ax2,'Type','Line');                      % Handle To Lines
LinesAx2(2).LineWidth = Linewidth;                                  % Set ‘LineWidth’
hold on
bodemag(syssisocontrolled3(perf_index(1),perf_index(2)))
grid
Fh = gcf;                                                   % Handle To Current Figure
Kids = Fh.Children;                                         % Children
AxAll = findobj(Kids,'Type','Axes');                        % Handles To Axes
Ax1 = AxAll(1);                                             % First Set Of Axes
LinesAx1 = findobj(Ax1,'Type','Line');                      % Handle To Lines
LinesAx1(2).LineWidth = Linewidth;                                  % Set ‘LineWidth’
Ax2 = AxAll(2);                                             % Second Set Of Axes
LinesAx2 = findobj(Ax2,'Type','Line');                      % Handle To Lines
LinesAx2(2).LineWidth = Linewidth;                                  % Set ‘LineWidth’



title('Bode diagram' ,'FontSize', FontSize);
xlabel( 'Frequency ', 'FontSize', FontSize);
ylabel( 'Magnitude ','FontSize', FontSize);

[hleg1, hobj1] = legend('Undamped system','DVF controlled', 'Lead controlled focused on 1st mode','Lead controlled focused on all modes');
set(hleg1,'position',[0 0 0.75 0.5])
textobj = findobj(hobj1, 'type', 'text');
set(textobj, 'Interpreter', 'latex', 'fontsize', FontSize);

%% Siso controllers, analysis on controlled patch tf
load('CLP1M1.mat')
load('CDVFP1M1.mat')
load('CLP1MA.mat')
Linewidth = 2;

syssisocontrolled1=feedback(sys,CDVFP1M1,first_patch(1),first_patch(2));
syssisocontrolled2=feedback(sys,CLP1M1,first_patch(1),first_patch(2));
syssisocontrolled3=feedback(sys,CLP1MA,first_patch(1),first_patch(2));

opts = bodeoptions('cstprefs');
opts.PhaseVisible = 'off';
% opts.FreqUnits = 'Hz';

% h = bodeplot(tf(1,[1,1]),opts);

figure
bodemag(sys(first_patch(1),first_patch(2)),opts)
Fh = gcf;                                                   % Handle To Current Figure
Kids = Fh.Children;                                         % Children
AxAll = findobj(Kids,'Type','Axes');                        % Handles To Axes
Ax1 = AxAll(1);                                             % First Set Of Axes
LinesAx1 = findobj(Ax1,'Type','Line');                      % Handle To Lines
LinesAx1(2).LineWidth = Linewidth;                                  % Set ‘LineWidth’
Ax2 = AxAll(2);                                             % Second Set Of Axes
LinesAx2 = findobj(Ax2,'Type','Line');                      % Handle To Lines
LinesAx2(2).LineWidth = Linewidth;                                  % Set ‘LineWidth’
hold on
bodemag(syssisocontrolled1(first_patch(1),first_patch(2)))
Fh = gcf;                                                   % Handle To Current Figure
Kids = Fh.Children;                                         % Children
AxAll = findobj(Kids,'Type','Axes');                        % Handles To Axes
Ax1 = AxAll(1);                                             % First Set Of Axes
LinesAx1 = findobj(Ax1,'Type','Line');                      % Handle To Lines
LinesAx1(2).LineWidth = Linewidth;                                  % Set ‘LineWidth’
Ax2 = AxAll(2);                                             % Second Set Of Axes
LinesAx2 = findobj(Ax2,'Type','Line');                      % Handle To Lines
LinesAx2(2).LineWidth = Linewidth;                                  % Set ‘LineWidth’
hold on
bodemag(syssisocontrolled2(first_patch(1),first_patch(2)))
grid
Fh = gcf;                                                   % Handle To Current Figure
Kids = Fh.Children;                                         % Children
AxAll = findobj(Kids,'Type','Axes');                        % Handles To Axes
Ax1 = AxAll(1);                                             % First Set Of Axes
LinesAx1 = findobj(Ax1,'Type','Line');                      % Handle To Lines
LinesAx1(2).LineWidth = Linewidth;                                  % Set ‘LineWidth’
Ax2 = AxAll(2);                                             % Second Set Of Axes
LinesAx2 = findobj(Ax2,'Type','Line');                      % Handle To Lines
LinesAx2(2).LineWidth = Linewidth;                                  % Set ‘LineWidth’
hold on
bodemag(syssisocontrolled3(first_patch(1),first_patch(2)))
grid
Fh = gcf;                                                   % Handle To Current Figure
Kids = Fh.Children;                                         % Children
AxAll = findobj(Kids,'Type','Axes');                        % Handles To Axes
Ax1 = AxAll(1);                                             % First Set Of Axes
LinesAx1 = findobj(Ax1,'Type','Line');                      % Handle To Lines
LinesAx1(2).LineWidth = Linewidth;                                  % Set ‘LineWidth’
Ax2 = AxAll(2);                                             % Second Set Of Axes
LinesAx2 = findobj(Ax2,'Type','Line');                      % Handle To Lines
LinesAx2(2).LineWidth = Linewidth;                                  % Set ‘LineWidth’



title('Bode diagram' ,'FontSize', FontSize);
xlabel( 'Frequency ', 'FontSize', FontSize);
ylabel( 'Magnitude ','FontSize', FontSize);

[hleg1, hobj1] = legend('Undamped system','DVF controlled', 'Lead controlled focused on 1st mode','Lead controlled focused on all modes');
set(hleg1,'position',[0 0 0.75 0.5])
textobj = findobj(hobj1, 'type', 'text');
set(textobj, 'Interpreter', 'latex', 'fontsize', FontSize);
%% RL Siso
controller = CLP1M1;
BO=(controller)*sys(2,2);
syssisocontrolled=feedback(sys,controller,first_patch(1),first_patch(2));
P = pole(tf(syssisocontrolled(first_patch(1),first_patch(2))));
rlocus(BO);
grid on
hold on
plot(P,'x',Color='r');
set(findall(gcf,'Type','line'),'LineWidth',Linewidth)
title('Root Locus' ,'FontSize', FontSize);
xlabel( 'Real axis', 'FontSize', FontSize);
ylabel( 'Imagniray axis','FontSize', FontSize);

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
grid
Fh = gcf;                                                   % Handle To Current Figure
Kids = Fh.Children;                                         % Children
AxAll = findobj(Kids,'Type','Axes');                        % Handles To Axes
Ax1 = AxAll(1);                                             % First Set Of Axes
LinesAx1 = findobj(Ax1,'Type','Line');                      % Handle To Lines
LinesAx1(2).LineWidth = Linewidth;                                  % Set ‘LineWidth’
Ax2 = AxAll(2);                                             % Second Set Of Axes
LinesAx2 = findobj(Ax2,'Type','Line');                      % Handle To Lines
LinesAx2(2).LineWidth = Linewidth;                                  % Set ‘LineWidth’
hold on
bodemag(syscontrolled(perf_index(1),perf_index(2)))
grid
Fh = gcf;                                                   % Handle To Current Figure
Kids = Fh.Children;                                         % Children
AxAll = findobj(Kids,'Type','Axes');                        % Handles To Axes
Ax1 = AxAll(1);                                             % First Set Of Axes
LinesAx1 = findobj(Ax1,'Type','Line');                      % Handle To Lines
LinesAx1(2).LineWidth = Linewidth;                                  % Set ‘LineWidth’
Ax2 = AxAll(2);                                             % Second Set Of Axes
LinesAx2 = findobj(Ax2,'Type','Line');                      % Handle To Lines
LinesAx2(2).LineWidth = Linewidth;                                  % Set ‘LineWidth’
hold on
bodemag(syscontrolled2(perf_index(1),perf_index(2)))
grid
Fh = gcf;                                                   % Handle To Current Figure
Kids = Fh.Children;                                         % Children
AxAll = findobj(Kids,'Type','Axes');                        % Handles To Axes
Ax1 = AxAll(1);                                             % First Set Of Axes
LinesAx1 = findobj(Ax1,'Type','Line');                      % Handle To Lines
LinesAx1(2).LineWidth = Linewidth;                                  % Set ‘LineWidth’
Ax2 = AxAll(2);                                             % Second Set Of Axes
LinesAx2 = findobj(Ax2,'Type','Line');                      % Handle To Lines
LinesAx2(2).LineWidth = Linewidth;                                  % Set ‘LineWidth’

title('Bode diagram' ,'FontSize', FontSize);
xlabel( 'Frequency ', 'FontSize', FontSize);
ylabel( 'Magnitude ','FontSize', FontSize);

[hleg1, hobj1] = legend('Undamped system', 'Lazy MIMO Lead','MIMO Lead');
set(hleg1,'position',[0 0 0.5 0.5])
textobj = findobj(hobj1, 'type', 'text');
set(textobj, 'Interpreter', 'latex', 'fontsize', FontSize);
