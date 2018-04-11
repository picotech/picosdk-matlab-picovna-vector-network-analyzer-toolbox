%% PicoVNA S-Parameter GUI
%
% This is an example GUI for S-parameter data collection in MATLAB, with
% the user able to choose 4 sets of data to be collected from each
% measurement.
%
% To run this example GUI, type the name of the file
% |S_Parameter_GUI|, in the MATLAB Command Window.
%
% The file |S_Parameter_GUI.m| must be on your MATLAB path along with
% the figure file associated with this GUI too,
% |S_Parameter_GUI.fig|, see <matlab:doc('addpath') addpath>.
%
% *Example*
%   S_Parameter_GUI;
% 
% *Description*
%   Demonstrates a GUI for connecting to the PicoVNA, load a calibration
%   file, make a measurment, collect 4 sets of data for selected
%   S-parameters and displays them.
%
% *Copyright:* © 2018 Pico Technology Ltd. See LICENSE file for terms.

function varargout = S_Parameter_GUI(varargin)
% S_PARAMETER_GUI MATLAB code for S_Parameter_GUI.fig
%      S_PARAMETER_GUI, by itself, creates a new S_PARAMETER_GUI or raises the existing
%      singleton*.
%
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @S_Parameter_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @S_Parameter_GUI_OutputFcn, ...
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

%% Creates the GUI on running the script
% --- Executes just before S_Parameter_GUI is made visible.
function S_Parameter_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to S_Parameter_GUI (see VARARGIN)

% Choose default command line output for S_Parameter_GUI
handles.output = hObject;
handles.p1sp='S11';
handles.p1meas='Real';
handles.p2sp='S11';
handles.p2meas='Real';
handles.p3sp='S11';
handles.p3meas='Real';
handles.p4sp='S11';
handles.p4meas='Real';
handles.calfile='?';

% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = S_Parameter_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%% Connect to PicoVNA
% Opens the VNA device upon button press
function opendevicebutton_Callback(hObject, eventdata, handles)
% hObject    handle to opendevicebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
picoVNACOMObj = connectVNA;
disp('Connected');
handles.picoVNACOMObj=picoVNACOMObj;

set(handles.opendevicebutton,'visible','off')
set(handles.closedevicebutton,'visible','on')
set(handles.calibrationfilepatheditbox,'visible','on')
set(handles.loadcalibrationbutton,'visible','on')

guidata(hObject,handles);

%% Disconnect VNA
% Disconnect VNA device on button press
function closedevicebutton_Callback(hObject, eventdata, handles)
% hObject    handle to closedevicebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disconnectVNA(handles.picoVNACOMObj);
disp('Disconnected');

cla(handles.plot1)
cla(handles.plot2)
cla(handles.plot3)
cla(handles.plot4)

set(handles.closedevicebutton,'visible','off')
set(handles.opendevicebutton,'visible','on')
set(handles.calibrationfilepatheditbox,'visible','off')
set(handles.loadcalibrationbutton,'visible','off')
set(handles.calibrationfilepatheditbox,'visible','off')
set(handles.plot1sparameterlist,'visible','off')
set(handles.plot1measurementtypelistbox,'visible','off')
set(handles.plot1,'visible','off')
set(handles.plot2sparameterlist,'visible','off')
set(handles.plot2measurementtypelistbox,'visible','off')
set(handles.plot2,'visible','off')
set(handles.plot3sparameterlist,'visible','off')
set(handles.plot3measuretypelist,'visible','off')
set(handles.plot3,'visible','off')
set(handles.plot4sparameterlist,'visible','off')
set(handles.plot4measuretypelist,'visible','off')
set(handles.plot4,'visible','off')
set(handles.measurebutton,'visible','off')


guidata(hObject,handles);

%% Set Calibration filepath
% Set file path for calibration file loading when the load calibration
% button is pressed
% A filepath must be set before the load calibration button is pressed
function calibrationfilepatheditbox_Callback(hObject, eventdata, handles)
% hObject    handle to calibrationfilepatheditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%
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
function loadcalibrationbutton_Callback(hObject, eventdata, handles)
% hObject    handle to loadcalibrationbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.picoVNACOMObj.LoadCal(handles.calfile);
disp('Calibration File Loaded');
set(handles.calibrationfilepatheditbox,'visible','off')
set(handles.loadcalibrationbutton,'visible','off')
set(handles.plot1sparameterlist,'visible','on')
set(handles.plot1measurementtypelistbox,'visible','on')
set(handles.plot1,'visible','on')
set(handles.plot2sparameterlist,'visible','on')
set(handles.plot2measurementtypelistbox,'visible','on')
set(handles.plot2,'visible','on')
set(handles.plot3sparameterlist,'visible','on')
set(handles.plot3measuretypelist,'visible','on')
set(handles.plot3,'visible','on')
set(handles.plot4sparameterlist,'visible','on')
set(handles.plot4measuretypelist,'visible','on')
set(handles.plot4,'visible','on')
set(handles.measurebutton,'visible','on')

%% Run Measurement
% Run a measurment sweep on the VNA, collect the data requested by the user
% and plot he data on the 4 plots.
function measurebutton_Callback(hObject, eventdata, handles)
% hObject    handle to measurebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.picoVNACOMObj.Measure('ALL');

[handles.p1frequency, handles.p1data] = getBlockDataVNA(handles.picoVNACOMObj,handles.p1sp,handles.p1meas);
[handles.p2frequency, handles.p2data] = getBlockDataVNA(handles.picoVNACOMObj,handles.p2sp,handles.p2meas);
[handles.p3frequency, handles.p3data] = getBlockDataVNA(handles.picoVNACOMObj,handles.p3sp,handles.p3meas);
[handles.p4frequency, handles.p4data] = getBlockDataVNA(handles.picoVNACOMObj,handles.p4sp,handles.p4meas);

plot(handles.plot1,handles.p1frequency,handles.p1data,'k');
xlabel(handles.plot1,'Frequency (Hz)');
ylabel(handles.plot1,handles.p1meas);

plot(handles.plot2,handles.p2frequency,handles.p2data,'k');
xlabel(handles.plot2,'Frequency (Hz)');
ylabel(handles.plot2,handles.p2meas);

plot(handles.plot3,handles.p3frequency,handles.p3data,'k');
xlabel(handles.plot3,'Frequency (Hz)');
ylabel(handles.plot3,handles.p3meas);

plot(handles.plot4,handles.p4frequency,handles.p4data,'k');
xlabel(handles.plot4,'Frequency (Hz)');
ylabel(handles.plot4,handles.p4meas);

%% Set Plot 1 S-Parameter
% Set the S-parameter for the data to be collected for displaying in
% plot 1.
function plot1sparameterlist_Callback(hObject, eventdata, handles)
% hObject    handle to plot1sparameterlist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%
% Hints: contents = cellstr(get(hObject,'String')) returns plot1sparameterlist contents as cell array
%        contents{get(hObject,'Value')} returns selected item from plot1sparameterlist
Spara={'S11', 'S12', 'S21', 'S22'};
handles.p1sp=Spara{1,(get(hObject,'Value'))};
guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function plot1sparameterlist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to plot1sparameterlist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% Set Plot 1 data type
% Set the data type returned from the measurement for displaying in plot 1.
function plot1measurementtypelistbox_Callback(hObject, eventdata, handles)
% hObject    handle to plot1measurementtypelistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%
% Hints: contents = cellstr(get(hObject,'String')) returns plot1measurementtypelistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from plot1measurementtypelistbox
MeasType={'real';, 'imag'; 'logmag'; 'phase'; 'swr'; 'gd'};
handles.p1meas=MeasType{(get(hObject,'Value')),1};
guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function plot1measurementtypelistbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to plot1measurementtypelistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% Set Plot 2 S-Parameter
% Set the S-paramater for the data to be collected for displaying in plot
% 2.
function plot2sparameterlist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to plot2sparameterlist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function plot2sparameterlist_Callback(hObject, eventdata, handles)
% hObject    handle to plot2sparameterlist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%
% Hints: contents = cellstr(get(hObject,'String')) returns plot2sparameterlist contents as cell array
%        contents{get(hObject,'Value')} returns selected item from plot2sparameterlist
Spara={'S11', 'S12', 'S21', 'S22'};
handles.p2sp=Spara{1,(get(hObject,'Value'))};
guidata(hObject,handles);


%% Set Plot 2 data type
% Set the data type returned from the measurement for displaying in plot 2.
function plot2measurementtypelistbox_Callback(hObject, eventdata, handles)
% hObject    handle to plot2measurementtypelistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%
% Hints: contents = cellstr(get(hObject,'String')) returns plot2measurementtypelistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from plot2measurementtypelistbox
MeasType={'real';, 'imag'; 'logmag'; 'phase'; 'swr'; 'gd'};
handles.p2meas=MeasType{(get(hObject,'Value')),1};
guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function plot2measurementtypelistbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to plot2measurementtypelistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% Set Plot 3 S-Parameter
% Set the S-paramater for the data to be collected for displaying in plot
% 3.
function plot3sparameterlist_Callback(hObject, eventdata, handles)
% hObject    handle to plot3sparameterlist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%
% Hints: contents = cellstr(get(hObject,'String')) returns plot3sparameterlist contents as cell array
%        contents{get(hObject,'Value')} returns selected item from plot3sparameterlist
Spara={'S11', 'S12', 'S21', 'S22'};
handles.p3sp=Spara{1,(get(hObject,'Value'))};
guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function plot3sparameterlist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to plot3sparameterlist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% Set Plot 3 data type
% Set the data type returned from the measurement for displaying in plot 3.
function plot3measuretypelist_Callback(hObject, eventdata, handles)
% hObject    handle to plot3measuretypelist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%
% Hints: contents = cellstr(get(hObject,'String')) returns plot3measuretypelist contents as cell array
%        contents{get(hObject,'Value')} returns selected item from plot3measuretypelist
MeasType={'real';, 'imag'; 'logmag'; 'phase'; 'swr'; 'gd'};
handles.p3meas=MeasType{(get(hObject,'Value')),1};
guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function plot3measuretypelist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to plot3measuretypelist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% Set Plot 4 S-Parameter
% Set the S-paramater for the data to be collected for displaying in plot
% 4.
function plot4sparameterlist_Callback(hObject, eventdata, handles)
% hObject    handle to plot4sparameterlist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%
% Hints: contents = cellstr(get(hObject,'String')) returns plot4sparameterlist contents as cell array
%        contents{get(hObject,'Value')} returns selected item from plot4sparameterlist
Spara={'S11', 'S12', 'S21', 'S22'};
handles.p4sp=Spara{1,(get(hObject,'Value'))};
guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function plot4sparameterlist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to plot4sparameterlist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%% Set Plot 4 data type
% Set the data type returned from the measurement for displaying in plot 4.
function plot4measuretypelist_Callback(hObject, eventdata, handles)
% hObject    handle to plot4measuretypelist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%
% Hints: contents = cellstr(get(hObject,'String')) returns plot4measuretypelist contents as cell array
%        contents{get(hObject,'Value')} returns selected item from plot4measuretypelist
MeasType={'real';, 'imag'; 'logmag'; 'phase'; 'swr'; 'gd'};
handles.p4meas=MeasType{(get(hObject,'Value')),1};
guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function plot4measuretypelist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to plot4measuretypelist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
