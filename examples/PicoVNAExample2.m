%% Example PicoVNA Demonstration

%% Clear workspace, command window and close figures

clear;
clc;
close all;

%% Create COM object

disp('PicoVNA MATLAB Example')
picoVNACOMObj = actxserver('PicoControl2.PicoVNA_2');

%% Connect to the device

findPicoVNA = picoVNACOMObj.FND;

if (findPicoVNA == 0)
   
    error('PicoVNAExample:PicoVNANotFound', 'A Pico VNA device has not been found');
    
end

%% Load calibration data 

picoVNACOMObj.LoadCal('DefCal.cal');

%% Set parameters

picoVNACOMObj.SetEnhance('Aver', '2');
picoVNACOMObj.SetFreqPlan(10, 29.95, 201, -6.0, 10000);

%% Run measurements and obtain data

% picoVNACOMObj.Measure('S11')disp
picoVNACOMObj.Measure('All');

s11.realData = picoVNACOMObj.GetData('S11', 'real', 0);

% Obtain frequency and real data values
s11.realDataValues = strsplit(s11.realData,',');

s11.freq                = str2double(s11.realDataValues(:,1:2:end));
s11.realDataPoints      = str2double(s11.realDataValues(:,2:2:end));

scrsz = get(groot,'ScreenSize');
s11Figure = figure('Name','PicoVNA Demonstration S11 Data Plots','NumberTitle','off','Position',[1 scrsz(4)/2 scrsz(3)/2 scrsz(4)/2]);
movegui(s11Figure, 'center');

subplot(2,2,1);
plot(s11.freq, s11.realDataPoints);
title('Plot of real magnitude v. frequency');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;

% Imaginary data
s11.imagData = picoVNACOMObj.GetData('S11', 'imag', 0);

% Obtain frequency and imaginary data values
s11.imagDataValues      = strsplit(s11.imagData,',');
s11.imagDataPoints      = str2double(s11.imagDataValues(:,2:2:end));

subplot(2,2,2);
plot(s11.freq, s11.imagDataPoints);
title('Plot of imaginary magnitude v. frequency');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;

% Log mag data
s11.logMagData = picoVNACOMObj.GetData('S11', 'logmag', 0);

% Obtain frequency and log mag values
s11.logMagDataValues    = strsplit(s11.logMagData,',');
s11.logMagDataPoints    = str2double(s11.logMagDataValues(:,2:2:end));

subplot(2,2,3);
plot(s11.freq, s11.logMagDataPoints);
title('Plot of log magnitude v. frequency');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
grid on;

% Phase data

s11.phaseData = picoVNACOMObj.GetData('S11', 'phase', 0);

% Obtain frequency and log mag values
s11.phaseDataValues     = strsplit(s11.phaseData,',');
s11.phaseDataPoints     = str2double(s11.phaseDataValues(:,2:2:end));

subplot(2,2,4);
plot(s11.freq, s11.phaseDataPoints);
title('Plot of phase v. frequency');
xlabel('Frequency (Hz)');
ylabel('Phase');
grid on;

%% Close the connection to the unit

picoVNACOMObj.CloseVNA();
delete(picoVNACOMObj);