%% PicoVNA S11 Smith Chart Example
%
% This is an example of using the VNA to collect data from a DUT and
% display the real and imaginary data for the S11 parameter on a Smith
% Chart.
%
% To run this example session, type the name of the file,
% PicoVNA_S11_Smith_Chart_Example, in the MATLAB Command Window.
%
% The file, PicoVNA_S11_Smith_Chart_Example.m must be on your MATLAB Path. For
% additional information on setting your MATLAB path, type 'help addpath' in
% the MATLAB Command Window.
%
% Additionally you must have the .cal file for your device in the current
% folder.
%
% <https://uk.mathworks.com/products/rftoolbox.html RF Toolbox> is required for this example.
%
% *Example:*
%   PicoVNA_S11_Smith_Chart_Example;
%
% *Description:*
%   Demonstrates how to use the VNA to collect data from a DUT and then display it onto a Smith Chart.
%
% *Copyright:* © 2017-2018 Pico Technology Ltd. See LICENSE file for terms.

%% Clear workspace, command window and close figures

clear;
clc;
close all;

%% Connect to VNA

picoVNACOMObj = connectVNA;

%% Load calibration
% Load a calibration and settings file.
% This needs to be generated and saved using the PicoVNA 2 software.
%
% Replace DefCal.cal with the correct calibration for your device, 'Pico TD
% demo with limits [Serial#].cal'.

picoVNACOMObj.LoadCal('DefCal.cal');

%% Stop button for exiting loop
% Create a stop button for ending data capture.
[stopFig.f, stopFig.h] = stopButtonVNA(1600, 800, 100, 50);   

flag = 1; % Use flag variable to indicate if stop button has been clicked (0).
setappdata(gcf, 'run', flag);


%% Capture and Plot Data

n = 0; % Number of Loops
go = 1; % While loop condition (1 = run, 0  = stop)

while go == 1
    
    % Instruct VNA do make a sweep measurement.
    picoVNACOMObj.Measure('ALL');
    
    % Get Log magnitude data for all S parameters.
    [s11.freq, s11.Real] = getBlockDataVNA(picoVNACOMObj,'S11','real');
    [s11.freq, s11.Imag] = getBlockDataVNA(picoVNACOMObj,'S11','imag');
    
    % Plot Smith Chart
    f = figure(2)
    set(f,'pos', [50 50 1300 800],'visible', 'off')
    smithchart;
    hold on
    plot(s11.Real,s11.Imag)
    drawnow
    hold off
    
    n = n + 1
    
   % Check if stop button has been pressed
    flag = getappdata(gcf, 'run');
    
    if flag == 0
        go = 0;
    end
    
end

%% Disconnect VNA

disconnectVNA(picoVNACOMObj)

% Tidy workspace
close PicoVNA 
clear ans flag go stopFig picoVNACOMObj