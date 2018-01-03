%% Pico VNA Golden DUT Data Collection Example
%
% This is an example of Golden DUT data aquisition using the PicoVNA.  This
% makes a measurement of the Golden DUT and retrieves the S21 log magnitude
% data from the VNA ready for use in the
% PicoVNA_DUT_PassFail_Testing_Example.
%
%To run this example session, type the name of the file,
%PicoVNA_GoldenDUT_Example, in the MATLAB Command Window.
%
%The file, PicoVNA_GoldenDUT_Example.m must be on your MATLAB PAth. For
%additional information on setting your MATLAB path, type 'help addpath' in
%the MATLAB Command Window
%
%Additionally you must have the DefCal.cal file in the current folder.
%
%*Example:*
%   PicoVNA_GoldenDUT_Example;
%
%*Description:*
%   Demonstrates how to use the VNA to collect and save data for a Golden
%   DUT for use in the PicoVNA_DUT_PassFail_Example.m script.
%
% *Copyright:* © 2015 - 2017 Pico Technology Ltd. See LICENSE file for terms.
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

%% Measure Golden DUT
% Make measurement of the Golden DUT and retrieve the log magnitude data
% for the S21 parameter

picoVNACOMObj.Measure('ALL');
[Golden.Frequency, Golden.S12LogMag]=getBlockDataVNA(picoVNACOMObj,'S21','logmag');

%% Save Golden DUT Data
% Save the Golden DUT data read for use in the Pass/Fail Testing Example

save ('GoldenDUT.mat', 'Golden');

%% Disconnect VNA
%Disconnect device object from hardware
disconnectVNA(picoVNACOMObj)

disp('Complete')