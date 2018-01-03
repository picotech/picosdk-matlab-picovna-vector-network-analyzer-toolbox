%% Pico VNA "Rapid Block" Example
%
% This is an example of setting up the connection with the VNA, loading
% calibration data, making measurements and collecting the log magnitude
% data for S11, S12, S21 and S22. 
%
%To run this example session, type the name of the file,
%PicoVNA_Rapid_Block_Example, in the MATLAB Command Window.
%
%The file, PicoVNA_Rapid_Block_Example.m must be on your MATLAB PAth. For
%additional information on setting your MATLAB path, type 'help addpath' in
%the MATLAB Command Window
%
%Additionally you must have the DefCal.cal file in the current folder.
%
%*Example:*
%   PicoVNA_Rapid_Block_Example;
%
%*Description:*
%   Demonstrates how to connect to the VNA, load ina calibration, make
%   measurements and collect data for S11, S12, S21 and S22.  The
%   measreuemtn and data collection is looped until the user stops the
%   process.
%
% *Copyright:* � 2015 - 2017 Pico Technology Ltd. See LICENSE file for terms.
%% Clear workspace, command window and close figures

clear;
clc;
close all;

%% Connect to VNA
picoVNACOMObj=connectVNA;

%% Load Calibration
%Load a calibration and setting file
%This needs to be generated and saved using the PicoVNA2 software
picoVNACOMObj.LoadCal('DefCal.cal');

%% Stop button for exiting loop
%Create a stop button for exiting rapid block capture and for displaying
%the data in.
[stopFig.f, stopFig.h] = stopButtonVNA(0, 50, 1450,1000);   

flag = 1; % Use flag variable to indicate if stop button has been clicked (0)
setappdata(gcf, 'run', flag);
%% Capture and Plot Data
n=0; %Number of Loops
go=1; %While loop condition (1 = run, 0 =stop)

while go==1
    %Instruct VNA do make a sweep measurement
    picoVNACOMObj.Measure('ALL');
    %Get Log magnitude data for all S parameters 
    [s11.freq, s11.logmagDataPoints]=getBlockDataVNA(picoVNACOMObj,'S11','logmag');
    [s22.freq, s22.logmagDataPoints]=getBlockDataVNA(picoVNACOMObj,'S22','logmag'); 
    [s12.freq, s12.logmagDataPoints]=getBlockDataVNA(picoVNACOMObj,'S12','logmag');
    [s21.freq, s21.logmagDataPoints]=getBlockDataVNA(picoVNACOMObj,'S21','logmag');
    
    
    %Get values for y-axes limits
    maxS11c=max(s11.logmagDataPoints);
    if n==0
        maxS11=maxS11c;
    end
    if maxS11c>maxS11
        maxS11=maxS11c;
    end
    minS11c=min(s11.logmagDataPoints);
    if n==0
        minS11=minS11c;
    end
    if minS11c<minS11
        minS11=minS11c;
    end
    
    maxS22c=max(s22.logmagDataPoints);
    if n==0
        maxS22=maxS22c;
    end
    if maxS22c>maxS22
        maxS22=maxS22c;
    end
    minS22c=min(s22.logmagDataPoints);
    if n==0
        minS22=minS22c;
    end
    if minS22c<minS22
        minS22=minS22c;
    end
    
    maxS12c=max(s12.logmagDataPoints);
    if n==0
        maxS12=maxS12c;
    end
    if maxS12c>maxS12
        maxS12=maxS12c;
    end
    minS12c=min(s12.logmagDataPoints);
    if n==0
        minS12=minS12c;
    end
    if minS12c<minS12
        minS12=minS12c;
    end
    
    maxS21c=max(s21.logmagDataPoints);
    if n==0
        maxS21=maxS21c;
    end
    if maxS21c>maxS21
        maxS21=maxS21c;
    end
    minS21c=min(s21.logmagDataPoints);
    if n==0
        minS21=minS21c;
    end
    if minS21c<minS21
        minS21=minS21c;
    end
    
    
    %Plot Data for all S-parameters
    subplot(2,2,1);
    plot(s11.freq, s11.logmagDataPoints);
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');
    ylim([minS11 maxS11]);
    title('S11')
    subplot(2,2,2);
    plot(s12.freq, s12.logmagDataPoints);
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');
    ylim([minS12 maxS12]);
    title('S12');
    subplot(2,2,3);
    plot(s21.freq, s21.logmagDataPoints);
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');
    ylim([minS21 maxS21]);
    title('S21');
    subplot(2,2,4);
    plot(s22.freq, s22.logmagDataPoints);
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');
    ylim([minS22 maxS22]);
    title('S22');
    drawnow
    
    n=n+1 %Current Loop Number
       
    %Check if stop button has been pressed
    flag=getappdata(gcf, 'run');
    if flag==0
        go=0;
    end
    clear maxS11c minS11c maxS12c minS12c maxS21c minS21c maxS22c minS22c
end
%% Disconnect VNA
disconnectVNA(picoVNACOMObj)
%tidy workspace
clear ans flag go maxS11 minS11 maxS12 minS12 maxS21 minS21 maxS22 minS22 picoVNACOMObj