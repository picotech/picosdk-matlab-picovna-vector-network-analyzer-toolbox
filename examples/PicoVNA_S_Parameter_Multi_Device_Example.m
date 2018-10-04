%% PicoVNA S-Parameter Multi Device Example
%
% This is an example of setting up the connection with three Pico Technology
% PicoVNA Vector Newtwork Analyzers, loading calibration data, making measurements and collecting
% the log magnitude data for S11, S12, S21 and S22 parameters on all devices.
%
% To run this example session, type the name of the file,
% |PicoVNA_S_Parameter_Multi_Device_Example|, in the MATLAB Command Window.
%
% The file, |PicoVNA_S_Parameter_Multi_Device_Example.m| must be on your MATLAB Path. For
% additional information on setting your MATLAB path, see
% <matlab:doc('addpath') addpath>.
%

% Additionally you must have the |.cal| file for your device in the current
% folder.
%
% *Example:*
%   PicoVNA_S-Parameter_Multi_Device_Example;
%
% *Description:*
% Demonstrates how to connect to three VNAs, load in a calibration, make
% measurements and collect data for S11, S12, S21 and S22 parameters on all devices.  
% The S-parameters are plotted onto auto-scaled plots.  The measurement and
% data collection is looped until the user stops the process.
%
% *Copyright:* © 2017-2018 Pico Technology Ltd. See LICENSE file for terms.

%% Clear workspace, command window and close figures

clear;
clc;
close all;

%% Connect to VNA

picoVNACOMObj = connectVNA_SN('DC2LZ9IY');
picoVNACOMObj_1 = connectVNA_SN_1('DC2L240G');
picoVNACOMObj_2 = connectVNA_SN_2('DC2NXKID');

%% Load Calibration
% Load a calibration and settings file.
% This needs to be generated and saved using the PicoVNA 2 software.
%
% Replace |DefCal.cal| with the correct calibration for your device, |Pico TD
% demo with limits [Serial#].cal|.
ans=picoVNACOMObj.LoadCal('?');
ans_1=picoVNACOMObj_1.LoadCal('?');
ans_2=picoVNACOMObj_2.LoadCal('?');

%% Stop button for exiting loop
% Create a stop button for exiting rapid block capture and for displaying
% the data in.
[stopFig.f, stopFig.h] = stopButtonVNA(0, 50, 1350,1000);   

flag = 1; % Use flag variable to indicate if stop button has been clicked (0)
setappdata(gcf, 'run', flag);

%% Capture and plot data

n = 0; % Number of Loops
go = 1; % While loop condition (1 = run, 0 = stop)

while go == 1
    
    n
    tic
    % Instruct VNA do make a sweep measurement
    picoVNACOMObj.Measure('ALL');
    toc
    picoVNACOMObj_1.Measure('ALL');
    toc
    picoVNACOMObj_2.Measure('ALL');
    
    toc
    
    % Get Log magnitude data for all S-Parameters 
    [s11.freq, s11.logmagDataPoints] = getBlockDataVNA(picoVNACOMObj,'S11','logmag');
    [s11_1.freq, s11_1.logmagDataPoints] = getBlockDataVNA_1(picoVNACOMObj_1,'S11','logmag');
    [s11_2.freq, s11_2.logmagDataPoints] = getBlockDataVNA_2(picoVNACOMObj_2,'S11','logmag');
    
    [s22.freq, s22.logmagDataPoints] = getBlockDataVNA(picoVNACOMObj,'S22','logmag'); 
    [s22_1.freq, s22_1.logmagDataPoints] = getBlockDataVNA_1(picoVNACOMObj_1,'S22','logmag'); 
    [s22_2.freq, s22_2.logmagDataPoints] = getBlockDataVNA_2(picoVNACOMObj_1,'S22','logmag');
    
    [s12.freq, s12.logmagDataPoints] = getBlockDataVNA(picoVNACOMObj,'S12','logmag');
    [s12_1.freq, s12_1.logmagDataPoints] = getBlockDataVNA_1(picoVNACOMObj_1,'S12','logmag');
    [s12_2.freq, s12_2.logmagDataPoints] = getBlockDataVNA_2(picoVNACOMObj_2,'S12','logmag');
    
    [s21.freq, s21.logmagDataPoints] = getBlockDataVNA(picoVNACOMObj,'S21','logmag');
    [s21_1.freq, s21_1.logmagDataPoints] = getBlockDataVNA_1(picoVNACOMObj_1,'S21','logmag');
    [s21_2.freq, s21_2.logmagDataPoints] = getBlockDataVNA_2(picoVNACOMObj_2,'S21','logmag');
    
    toc
    
    % Get values for y-axes limits
    maxS11c = max(s11.logmagDataPoints);
    maxS11c_1 = max(s11_1.logmagDataPoints);
    maxS11c_2 = max(s11_2.logmagDataPoints);
    
    if n == 0
        maxS11 = maxS11c;
    elseif maxS11c > maxS11
        maxS11 = maxS11c;
    elseif maxS11c_1 > maxS11
        maxS11 = maxS11c_1;
    elseif maxS11c_2 > maxS11
        maxS11 = maxS11c_2;
    end
    
    minS11c = min(s11.logmagDataPoints);
    minS11c_1 = min(s11_1.logmagDataPoints);
    minS11c_2 = min(s11_2.logmagDataPoints);
    
    if n == 0
        minS11 = minS11c;
    elseif minS11c < minS11
        minS11 = minS11c;
    elseif minS11c_1 < minS11
        minS11 = minS11c_1;
    elseif minS11c_2 <minS11
        minS11 = minS11c_2;
    end
    
    maxS22c = max(s22.logmagDataPoints);
    maxS22c_1 = max(s22_1.logmagDataPoints);
    maxS22c_2 = max(s22_2.logmagDataPoints);
    
    if n == 0
        maxS22 = maxS22c;
    elseif maxS22c > maxS22
        maxS22 = maxS22c;
    elseif maxS22c_1 > maxS22
        maxS22 = maxS22c_1;
    elseif maxS22c_2 > maxS22
        maxS22 = maxS22c_2;
    end
    
    minS22c = min(s22.logmagDataPoints);
    minS22c_1 = min(s22_1.logmagDataPoints);
    minS22c_2 = min(s22_2.logmagDataPoints);
    
    if n == 0
        minS22 = minS22c;
    elseif minS22c < minS22
        minS22 = minS22c;
    elseif minS22c_1 < minS22
        minS22 = minS22c_1;
    elseif minS22c_2 < minS22
        minS22 = minS22c_2;
    end
    
    maxS12c = max(s12.logmagDataPoints);
    maxS12c_1 = max(s12_1.logmagDataPoints);
    maxS12c_2 = max(s12_2.logmagDataPoints);
    
    if n == 0
        maxS12 = maxS12c;
    elseif maxS12c > maxS12
        maxS12 = maxS12c;
    elseif maxS12c_1 > maxS12
        maxS12 = maxS12c_1;
    elseif maxS12c_2 > maxS12
        maxS12 = maxS12c_2;
    end
    
    minS12c = min(s12.logmagDataPoints);
    minS12c_1 = min(s12_1.logmagDataPoints);
    minS12c_2 = min(s12_2.logmagDataPoints);
    
    if n == 0
        minS12 = minS12c;
    elseif minS12c < minS12
        minS12 = minS12c;
    elseif minS12c_1 < minS12
        minS12 = minS12c_1;
    elseif minS12c_2 < minS12
        minS12 = minS12c_2;
    end
    
    maxS21c = max(s21.logmagDataPoints);
    maxS21c_1 = max(s21_1.logmagDataPoints);
    maxS21c_2 = max(s21_2.logmagDataPoints);
    
    if n == 0
        maxS21 = maxS21c;
    elseif maxS21c > maxS21
        maxS21 = maxS21c;
    elseif maxS21c_1 > maxS21
        maxS21 = maxS21c_1;
    elseif maxS21c_2 > maxS21
        maxS21 = maxS21c_2;
    end
    
    minS21c = min(s21.logmagDataPoints);
    minS21c_1 = min(s21_1.logmagDataPoints);
    minS21c_2 = min(s21_2.logmagDataPoints);
    
    if n == 0
        minS21 = minS21c;
    elseif minS21c < minS21
        minS21 = minS21c;
    elseif minS21c_1 < minS21
        minS21 = minS21c_1;
    elseif minS21c_2 < minS21
        minS21 = minS21c_2;
    end
    
    toc
    
    % Plot Data for all S-parameters
    subplot(2,2,1);
    plot(s11.freq, s11.logmagDataPoints, 'b');
    hold on
    plot(s11_1.freq, s11_1.logmagDataPoints, 'r');
    plot(s11_2.freq, s11_2.logmagDataPoints, 'g');
    hold off
    xlabel('Frequency (Hz)');
    ylabel('Magnitude (dB)');
    ylim([minS11-5 maxS11+5]);
    title('S11')
    
    subplot(2,2,2);
    plot(s12.freq, s12.logmagDataPoints,'b');
    hold on
    plot(s12_1.freq, s12_1.logmagDataPoints, 'r');
    plot(s12_2.freq, s12_2.logmagDataPoints, 'g');
    hold off
    xlabel('Frequency (Hz)');
    ylabel('Magnitude (dB)');
    ylim([minS12-5 maxS12+5]);
    title('S12');
    
    subplot(2,2,3);
    plot(s21.freq, s21.logmagDataPoints,'b');
    hold on
    plot(s21_1.freq, s21_1.logmagDataPoints, 'r');
    plot(s21_2.freq, s21_2.logmagDataPoints, 'g');
    hold off
    xlabel('Frequency (Hz)');
    ylabel('Magnitude (dB)');
    ylim([minS21-5 maxS21+5]);
    title('S21');
    
    subplot(2,2,4);
    plot(s22.freq, s22.logmagDataPoints,'b');
    hold on
    plot(s22_1.freq, s22_1.logmagDataPoints, 'r');
    plot(s22_2.freq, s22_2.logmagDataPoints, 'g');
    hold off
    xlabel('Frequency (Hz)');
    ylabel('Magnitude (dB)');
    ylim([minS22-5 maxS22+5]);
    title('S22');
    
    drawnow
    
    toc
    
    
       
    % Check if stop button has been pressed
    flag = getappdata(gcf, 'run');
    if flag == 0
        go = 0;
    end
    clear maxS11c minS11c maxS12c minS12c maxS21c minS21c maxS22c minS22c
    clear maxS11c_1 minS11c_1 maxS12c_1 minS12c_1 maxS21c_1 minS21c_1 maxS22c_1 minS22c_1
    clear maxS11c_2 minS11c_2 maxS12c_2 minS12c_2 maxS21c_2 minS21c_2 maxS22c_2 minS22c_2
    
    toc
    n = n+1; % Current Loop Number
end
%% Disconnect VNA

disconnectVNA(picoVNACOMObj)
disconnectVNA_1(picoVNACOMObj_1)
disconnectVNA_2(picoVNACOMObj_2)


% Tidy workspace
clear ans flag go maxS11 minS11 maxS12 minS12 maxS21 minS21 maxS22 minS22 picoVNACOMObj picoVNACOMObj_1 picoVNACOMObj_2 n s11 ans_1 ans_2
