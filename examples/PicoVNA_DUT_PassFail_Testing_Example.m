%% PicoVNA Pass-Fail Testing Example
%
% This is an example of a Pass/Fail test using the PicoVNA. This compares a
% S21 log magnitude sweep from a device to the same measurement of a
% previously measured Golden DUT using the PicoVNA_GoldenDUT_Example.m file.
%
% To run this example session, type the name of the file,
% PicoVNA_DUT_PassFail_Testing_Example, in the MATLAB Command Window.
%
% The file, PicoVNA_DUT_PassFail_Testing_Example.m must be on your MATLAB
% Path. For additional information on setting your MATLAB path, type 'help
% addpath' in the MATLAB Command Window
%
% Additionally you must have the .cal file for your device and the
% GoldenDUT.mat file in the current folder.
%
% *Example:*
%   PicoVNA_DUT_PassFail_Testing_Example;
%
% *Description:*
%   Demonstrates how to use the VNA to compare DUTs to a saved Golden DUT
%   and evaluate if the DUT is within tolerance of the Golden DUT
%   measurement.
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
% This needs to be generated and saved using the PicoVNA2 software.

% Replace DefCal.cal with the correct calibration for your device, 'Pico TD
% demo with limits [Serial#].cal'.

picoVNACOMObj.LoadCal('DefCal.cal');

%% Load Golden DUT log magnitude
% Load in the reference data from the Golden Dut captured using
% PicoVNA_GoldenDUT_Example.m

load('GoldenDUT.mat');

%% Create pass band
% Create a pass band using the Golden DUT data and the tolererance in dB of
% the testing for comparison with the DUTs later.

tolerance = 0.2; % Tolerance of the cable in dB

% Create the upper and lower bounds of the pass band.
Error.Upper = Golden.S12LogMag + tolerance;
Error.Lower = Golden.S12LogMag - tolerance;

%% Testing
% Create a stop button for ending testing.
[stopFig.f, stopFig.h] = stopButtonVNA(50, 200, 1000, 500);   

flag = 1; % Use flag variable to indicate if stop button has been clicked (0)
setappdata(gcf, 'run', flag);
stopbutton = gcf;

% Create the axes for plotting the test measurements on with the pass band
% displayed.
ax1 = subplot(1,1,1);
plot(ax1,Golden.Frequency,Error.Upper,'k');
hold on
plot(ax1,Golden.Frequency,Error.Lower,'k');
hold off
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Test Limits');

%%
n = 0; % Number of Loops
go = 1; % While loop condition (1 = run, 0 = stop)

while go == 1
    
    % Run test on mouse click on the figure
    k = waitforbuttonpress;
    % Check if stop button has been pressed
    flag = getappdata(stopbutton, 'run');
    
    if flag == 0
        go = 0;
    end
    
    if k == 0
        
        n = n+1
        
        % Make measurement of the DUT
        picoVNACOMObj.Measure('ALL');
        
        % Collect the S21 Log Magnitude data from the VNA
        [test.frequency, test.logmag] = getBlockDataVNA(picoVNACOMObj,'S21','logmag');
        
        % Compare the test data with the pass band limits at every point
        for i = 1:length(test.logmag)
            
            if (test.logmag(1,i) >= Error.Upper(1,i)) || (test.logmag(1,i) <= Error.Lower(1,i))
                test.Check = 1; % Set Check to 1 if the point is outside of the pass band
            else
                test.Check = 0; % Set Check to 0 if the point is inside of the pass band
            end
            
        end
        
        % Inspect Check to see if any point failed the tolerance testing and
        % record whether the test was a pass or a fail.
        % If the DUT passed the test it is assigned a 1, if it failed it is
        % assigned a 0.        
        if sum(test.Check) == 0
            pass(n,1) = 1; 
        else
            pass(n,1) = 0;
        end
        
        % Plot the Test Results
        plot(ax1,Golden.Frequency,Error.Upper,'k');
        hold on
        plot(ax1,Golden.Frequency,Error.Lower,'k');
        
        % The test data is plotted in green with "Test Passed" title if
        % pass = 1 for the DUT
        if pass(n,1) == 1
            
            plot(ax1,test.frequency,test.logmag,'g');
            title('Test Passed');
            
        % The test data is plotted in red with "Test Failed" title if pass = 0
        % for the DUT
        else
            
            plot(ax1,test.frequency,test.logmag,'r');
            title(['Test Failed']);
            
        end
        
        xlabel('Frequency (Hz)');
        ylabel('Magnitude');
        drawnow
        hold off
        disp('Test Complete')
        
    end
  
end

%% Disconnect VNA

disconnectVNA(picoVNACOMObj)
close PicoVNA 
clear ans ax1 flag go i k n picoVNACOMObj