%% PicoVNA Pass Fail Testing GUI
%
% This is an example GUI for pass/fail testing of DUTs in MATLAB for
% comparison with data from a Golden DUT.
%
% To run this example GUI, type the name of the file
% |Pass_Fail_Testing_GUI|, in the MATLAB Command Window.
%
% The file |Pass_Fail_Testing_GUI.m| must be on your MATLAB path along with
% the figure file associated with this GUI too,
% |Pass_Fail_Testing_GUI.fig|, see <matlab:doc('addpath') addpath>.
%
% *Example*
%   Pass_Fail_Testing_GUI;
% 
% *Description*
%   Demonstrates how to use the PicoVNA to collect Golden DUT data then
%   collect data from DUTs and evaluate if the DUT is within tolerance of
%   the Golden DUT data using a GUI.
%
% *Copyright:* © 2018 Pico Technology Ltd. See LICENSE file for terms.

function varargout = Pass_Fail_Testing_GUI(varargin)
% PASS_FAIL_TESTING_GUI MATLAB code for Pass_Fail_Testing_GUI.fig
%      PASS_FAIL_TESTING_GUI, by itself, creates a new PASS_FAIL_TESTING_GUI or raises the existing
%      singleton*.
%

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Pass_Fail_Testing_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Pass_Fail_Testing_GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

%% Create the GUI on running the script
% --- Executes just before Pass_Fail_Testing_GUI is made visible.
function Pass_Fail_Testing_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Pass_Fail_Testing_GUI (see VARARGIN)

% Choose default command line output for Pass_Fail_Testing_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = Pass_Fail_Testing_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



%% Connect PicoVNA
% Opens the VNA device upon button press
function opendevicebutton_Callback(hObject, eventdata, handles)
% hObject    handle to opendevicebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
picoVNACOMObj = connectVNA;
disp('Connected');
handles.picoVNACOMObj=picoVNACOMObj;

set(handles.closedevicebutton,'visible','on')
set(handles.entertoleranceaditbox,'visible','on')
set(handles.texttolerancetext,'visible','on')
set(handles.loadcalibrationfilebutton,'visible','on')
set(handles.calibrationfilepatheditbox,'visible','on')
set(handles.collectreferencedatabutton,'visible','on')
set(handles.opendevicebutton,'visible','off')

guidata(hObject,handles);

%% Disconnect VNA
% Disconnect VNA device on button press
function closedevicebutton_Callback(hObject, eventdata, handles)
% hObject    handle to closedevicebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disconnectVNA(handles.picoVNACOMObj);
disp('Disconnected');

set(handles.closedevicebutton,'visible','off')
set(handles.entertoleranceaditbox,'visible','off')
set(handles.texttolerancetext,'visible','off')
set(handles.loadcalibrationfilebutton,'visible','off')
set(handles.calibrationfilepatheditbox,'visible','off')
set(handles.collectreferencedatabutton,'visible','off')
set(handles.collecttestdatabutton,'visible','off')
cla(handles.dataplot)
set(handles.dataplot,'visible','off')
set(handles.finishtestingbutton,'visible','off')
set(handles.opendevicebutton,'visible','on')

guidata(hObject,handles);

%% Golden DUT Data Collection
% Make measurement of the Golden DUT and retrieve the log magnitude data
% for the S21 parameter.
% Creates tolerance bands based on the tolerance inputted by the user.
function collectreferencedatabutton_Callback(hObject, eventdata, handles)
% hObject    handle to collectreferencedatabutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.picoVNACOMObj.Measure('ALL');
[handles.RefFrequency, handles.RefS12LogMag] = getBlockDataVNA(handles.picoVNACOMObj,'S21','logmag');
handles.Error.Upper = handles.RefS12LogMag + handles.tolerance;
handles.Error.Lower = handles.RefS12LogMag - handles.tolerance;
disp('Reference Data Collected');

set(handles.entertoleranceaditbox,'visible','off')
set(handles.texttolerancetext,'visible','off')
set(handles.loadcalibrationfilebutton,'visible','off')
set(handles.calibrationfilepatheditbox,'visible','off')
set(handles.collectreferencedatabutton,'visible','off')
set(handles.collecttestdatabutton,'visible','on')
set(handles.finishtestingbutton,'visible','on')

guidata(hObject,handles);

%% Set Calibration filepath
% Set file path for calibration file loading when the load calibration
% button is pressed
% A filepath must be set before the load calibration button is pressed
function calibrationfilepatheditbox_Callback(hObject, eventdata, handles)
% hObject    handle to calibrationfilepatheditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of calibrationfilepatheditbox as text
%        str2double(get(hObject,'String')) returns contents of calibrationfilepatheditbox as a double
handles.calfile=get(hObject,'String');
disp('Calibration Filepath Set');
disp(handles.calfile);
guidata(hObject,handles);

function calibrationfilepatheditbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to calibrationfilepatheditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% Load Calibration File
% Load a calibration and settings file upon button press.
% This needs to be generated and saved using the PicoVNA2 software.
% Load the calibration file set by the calibration file path edit box
% input.
function loadcalibrationfilebutton_Callback(hObject, eventdata, handles)
% hObject    handle to loadcalibrationfilebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.picoVNACOMObj.LoadCal(handles.calfile);
disp('Calibration File Loaded');

%% Collect DUT test data
% Collects test data from DUT testing upon button press.
% Compares the collected data to the Golden DUT tolerance limits.
% If the data is within the limits it displays in green while if it is
% outide of the limits it displays in red.
function collecttestdatabutton_Callback(hObject, eventdata, handles)
% hObject    handle to collecttestdatabutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.picoVNACOMObj.Measure('ALL');
[handles.test.frequency, handles.test.logmag] = getBlockDataVNA(handles.picoVNACOMObj,'S21','logmag');
for i = 1:length(handles.test.logmag)
            
            if (handles.test.logmag(1,i) >= handles.Error.Upper(1,i)) || (handles.test.logmag(1,i) <= handles.Error.Lower(1,i))
                handles.test.Check = 1; % Set Check to 1 if the point is outside of the pass band
            else
                handles.test.Check = 0; % Set Check to 0 if the point is inside of the pass band
            end
            
end

set(handles.dataplot,'visible','on')

plot(handles.dataplot,handles.RefFrequency,handles.Error.Upper,'k');
hold on
plot(handles.dataplot,handles.RefFrequency,handles.Error.Lower,'k');
if handles.test.Check == 1
    plot(handles.dataplot,handles.test.frequency,handles.test.logmag,'g');
else
    plot(handles.dataplot,handles.test.frequency,handles.test.logmag,'r');
end
hold off
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Test Limits');

disp('Test Finished')
        
%% Enter Test Tolerance 
% Enter the tolerance for comparing the limits for the test DUT when
% compared to the Golden DUT in dB.
function entertoleranceaditbox_Callback(hObject, eventdata, handles)
% hObject    handle to entertoleranceaditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of entertoleranceaditbox as text
%        str2double(get(hObject,'String')) returns contents of entertoleranceaditbox as a double
handles.tolerance=str2double(get(hObject,'String'));
disp('Test Tolerance Set')
X=sprintf('%s dB',handles.tolerance);
disp(X)
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function entertoleranceaditbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to entertoleranceaditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% Create Plotting Area
% Create the plot area for plotting the data from the DUT test.
function dataplot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dataplot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
%
% Hint: place code in OpeningFcn to populate dataplot

%% Finish Testing
% Button press finishes the testing and returns to the previous button
function finishtestingbutton_Callback(hObject, eventdata, handles)
% hObject    handle to finishtestingbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.entertoleranceaditbox,'visible','on')
set(handles.texttolerancetext,'visible','on')
set(handles.loadcalibrationfilebutton,'visible','on')
set(handles.calibrationfilepatheditbox,'visible','on')
set(handles.collectreferencedatabutton,'visible','on')
set(handles.collecttestdatabutton,'visible','off')
cla(handles.dataplot)
set(handles.dataplot,'visible','off')
set(handles.finishtestingbutton,'visible','off')
