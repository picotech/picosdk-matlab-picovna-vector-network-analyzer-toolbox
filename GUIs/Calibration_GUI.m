%% PicoVNA Calibration GUI
%
% This is an example GUI for doing a All calibration with enchanced
% isolation on the VNA and save the calibration to a .cal file.
%
% To run this example GUI, type the name of the file
% |Calibration_GUI|, in the MATLAB Command Window.
%
% The file |Calibration_GUI.m| must be on your MATLAB path along with
% the figure file associated with this GUI too,
% |Calibration_GUI.fig|, see <matlab:doc('addpath') addpath>.
%
% *Example*
%   Calibration_GUI;
% 
% *Description*
%   Demonstrates a GUI for completing a All calibration on the PicoVNA 
%   including the enhanced isolation.  This calibration can then be saved
%   as a .cal file for use in other examples or in the PicoVNA2 software.
%
% *Copyright:* © 2018 Pico Technology Ltd. See LICENSE file for terms.

function varargout = Calibration_GUI(varargin)
% CALIBRATION_GUI MATLAB code for Calibration_GUI.fig
%      CALIBRATION_GUI, by itself, creates a new CALIBRATION_GUI or raises the existing
%      singleton*.

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Calibration_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Calibration_GUI_OutputFcn, ...
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

% --- Executes just before Calibration_GUI is made visible.
function Calibration_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Calibration_GUI (see VARARGIN)

% Choose default command line output for Calibration_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = Calibration_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%% Connect VNA
% Open the VNA device upon button press
function opendevicebutton_Callback(hObject, eventdata, handles)
% hObject    handle to opendevicebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
picoVNACOMObj = connectVNA;
disp('Connected');
handles.picoVNACOMObj=picoVNACOMObj;
guidata(hObject,handles);

set(handles.closedevicebutton,'visible','on')
set(handles.opendevicebutton,'visible','off')
set(handles.calibrationfilepatheditbox,'visible','on')
set(handles.loadcalibrationbutton,'visible','on')
set(handles.calibrationfilepatheditbox,'visible','on')
set(handles.loadcalibrationbutton,'visible','on')


%% Disconnet VNA
% Disconnect the VNA device upon button press
function closedevicebutton_Callback(hObject, eventdata, handles)
% hObject    handle to closedevicebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disconnectVNA(handles.picoVNACOMObj);
disp('Disconnected');
guidata(hObject,handles);

set(handles.closedevicebutton,'visible','off')
set(handles.opendevicebutton,'visible','on')
set(handles.calibrationfilepatheditbox,'visible','off')
set(handles.loadcalibrationbutton,'visible','off')
set(handles.startfrequencyeditbox,'visible','off')
set(handles.endfrequencyeditbox,'visible','off')
set(handles.powerleveleditbox,'visible','off')
set(handles.bandwidtheditbox,'visible','off')
set(handles.numberofpointslistbox,'visible','off')
set(handles.setfrequencyplanbutton,'visible','off')
set(handles.malecalibrationkitfilepatheditbox,'visible','off')
set(handles.femalecalibrationkitfilepatheditbox,'visible','off')
set(handles.loadcalibrationkitsbutton,'visible','off')
set(handles.allcalibrationtextbox,'visible','off')
set(handles.calibrateloadbutton,'visible','off')
set(handles.calibrateopenbutton,'visible','off')
set(handles.calibrateshortbutton,'visible','off')
set(handles.calibratethrubutton,'visible','off')
set(handles.calibrateisolationbutton,'visible','off')
set(handles.restartcalibratingbutton,'visible','off')
set(handles.savestatusandcalibrationbutton,'visible','off')


%% Set calibration file path
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
% --- Executes during object creation, after setting all properties.
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
set(handles.startfrequencyeditbox,'visible','on')
set(handles.endfrequencyeditbox,'visible','on')
set(handles.powerleveleditbox,'visible','on')
set(handles.bandwidtheditbox,'visible','on')
set(handles.numberofpointslistbox,'visible','on')
set(handles.setfrequencyplanbutton,'visible','on')



%% Set start frequency
% Set the start frequency for the calibration sweep
function startfrequencyeditbox_Callback(hObject, eventdata, handles)
% hObject    handle to startfrequencyeditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of startfrequencyeditbox as text
%        str2double(get(hObject,'String')) returns contents of startfrequencyeditbox as a double
handles.startfrequency=(get(hObject,'String'));
guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function startfrequencyeditbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startfrequencyeditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%% Set End Frequency
% Set the end frequency for the calibrtion sweep
function endfrequencyeditbox_Callback(hObject, eventdata, handles)
% hObject    handle to endfrequencyeditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of endfrequencyeditbox as text
%        str2double(get(hObject,'String')) returns contents of endfrequencyeditbox as a double
handles.stopfrequency=str2double(get(hObject,'String'));
guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function endfrequencyeditbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to endfrequencyeditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%% Set Power Level
% Set the power level for the calibration sweep
function powerleveleditbox_Callback(hObject, eventdata, handles)
% hObject    handle to powerleveleditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of powerleveleditbox as text
%        str2double(get(hObject,'String')) returns contents of powerleveleditbox as a double
handles.powerlevel=(get(hObject,'String'));
guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function powerleveleditbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to powerleveleditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%% Set Bandwidth
% Set the bandwidth of the calibration sweep
function bandwidtheditbox_Callback(hObject, eventdata, handles)
% hObject    handle to bandwidtheditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of bandwidtheditbox as text
%        str2double(get(hObject,'String')) returns contents of bandwidtheditbox as a double
handles.bandwidth=(get(hObject,'String'));
guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function bandwidtheditbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bandwidtheditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%% Set Number of Points
% Set the number of points for the calibration sweep
function numberofpointslistbox_Callback(hObject, eventdata, handles)
% hObject    handle to numberofpointslistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns numberofpointslistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from numberofpointslistbox
numberofpoints=(get(hObject,'Value'));
values=[51,101,201,401,801,1024,2001,3001,4001,5001,6001,7001,8001,9001];
handles.numberofpoints=values(1,numberofpoints);
guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function numberofpointslistbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numberofpointslistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%% Set Frequency Plan
% Set the frequency plan for the calibration sweet using the values entered
% by the user.
function setfrequencyplanbutton_Callback(hObject, eventdata, handles)
% hObject    handle to setfrequencyplanbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.frequencystep=num2str((handles.stopfrequency-(str2double(handles.startfrequency)))/(handles.numberofpoints -1))
status=handles.picoVNACOMObj.SetFreqPlan(handles.startfrequency, handles.frequencystep, num2str(handles.numberofpoints), handles.powerlevel, handles.bandwidth)

set(handles.startfrequencyeditbox,'visible','off')
set(handles.endfrequencyeditbox,'visible','off')
set(handles.powerleveleditbox,'visible','off')
set(handles.bandwidtheditbox,'visible','off')
set(handles.numberofpointslistbox,'visible','off')
set(handles.setfrequencyplanbutton,'visible','off')
set(handles.malecalibrationkitfilepatheditbox,'visible','on')
set(handles.femalecalibrationkitfilepatheditbox,'visible','on')
set(handles.loadcalibrationkitsbutton,'visible','on')



%% Set male calibration kit file path
% Set the file path for the male calibration kit file for loading
function malecalibrationkitfilepatheditbox_Callback(hObject, eventdata, handles)
% hObject    handle to malecalibrationkitfilepatheditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of malecalibrationkitfilepatheditbox as text
%        str2double(get(hObject,'String')) returns contents of malecalibrationkitfilepatheditbox as a double
handles.malecalibrationkitfilepath=get(hObject,'String');
guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function malecalibrationkitfilepatheditbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to malecalibrationkitfilepatheditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%% Set female calibration kit file path
% Set the file path for loading the female calibration kit file
function femalecalibrationkitfilepatheditbox_Callback(hObject, eventdata, handles)
% hObject    handle to femalecalibrationkitfilepatheditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of femalecalibrationkitfilepatheditbox as text
%        str2double(get(hObject,'String')) returns contents of femalecalibrationkitfilepatheditbox as a double
handles.femalecalibrationkitfilepath=get(hObject,'String');
guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function femalecalibrationkitfilepatheditbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to femalecalibrationkitfilepatheditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% Load Calibration Kits
% Load the calibration kit using the paths defined by the user
function loadcalibrationkitsbutton_Callback(hObject, eventdata, handles)
% hObject    handle to loadcalibrationkitsbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
status=handles.picoVNACOMObj.SelectKit(handles.malecalibrationkitfilepath,1);
status=handles.picoVNACOMObj.SelectKit(handles.femalecalibrationkitfilepath,2);

set(handles.malecalibrationkitfilepatheditbox,'visible','off')
set(handles.femalecalibrationkitfilepatheditbox,'visible','off')
set(handles.loadcalibrationkitsbutton,'visible','off')
set(handles.allcalibrationtextbox,'visible','on')
set(handles.calibrateloadbutton,'visible','on')
set(handles.calibrateopenbutton,'visible','on')
set(handles.calibrateshortbutton,'visible','on')
set(handles.calibratethrubutton,'visible','on')
set(handles.calibrateisolationbutton,'visible','on')
set(handles.restartcalibratingbutton,'visible','on')
set(handles.savestatusandcalibrationbutton,'visible','on')

%% Run Load Calibration
% Runs the Load calibration for the VNA
function calibrateloadbutton_Callback(hObject, eventdata, handles)
% hObject    handle to calibrateloadbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
status=handles.picoVNACOMObj.MeasCal('All','Load');

set(handles.calibrateloadbutton,'visible','off')

%% Run Open Calibration
% Runs the Open calibration for the VNA
function calibrateopenbutton_Callback(hObject, eventdata, handles)
% hObject    handle to calibrateopenbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
status=handles.picoVNACOMObj.MeasCal('All','Open');

set(handles.calibrateopenbutton,'visible','off')

%% Run Short Calibration
% Runs the Short calibration for the VNA
function calibrateshortbutton_Callback(hObject, eventdata, handles)
% hObject    handle to calibrateshortbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
status=handles.picoVNACOMObj.MeasCal('All','Short');

set(handles.calibrateshortbutton,'visible','off')

%% Run Thru calibration
% Runs the Thru calibration for the VNA
function calibratethrubutton_Callback(hObject, eventdata, handles)
% hObject    handle to calibratethrubutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
status=handles.picoVNACOMObj.MeasCal('All','Thru');

set(handles.calibratethrubutton,'visible','off')

%% Run Enhanced Isolation calibration
% Runs the enhanced Isolation calibration for the VNA
function calibrateisolationbutton_Callback(hObject, eventdata, handles)
% hObject    handle to calibrateisolationbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
status=handles.picoVNACOMObj.MeasCal('All','Isolation1');

set(handles.calibrateisolationbutton,'visible','off')

%% Restart Calibration
% Redisplays all of the calibration buttons to redo any or all of the
% calibration steps
function restartcalibratingbutton_Callback(hObject, eventdata, handles)
% hObject    handle to restartcalibratingbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.calibrateloadbutton,'visible','on')
set(handles.calibrateopenbutton,'visible','on')
set(handles.calibrateshortbutton,'visible','on')
set(handles.calibratethrubutton,'visible','on')
set(handles.calibrateisolationbutton,'visible','on')


%% Save Calibration
% Opens the pop-up to save the calibration as a .cal file
function savestatusandcalibrationbutton_Callback(hObject, eventdata, handles)
% hObject    handle to savestatusandcalibrationbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
status=handles.picoVNACOMObj.AppCal('All')
status=handles.picoVNACOMObj.SaveCal('?')
set(handles.allcalibrationtextbox,'visible','off')
set(handles.calibrateloadbutton,'visible','off')
set(handles.calibrateopenbutton,'visible','off')
set(handles.calibrateshortbutton,'visible','off')
set(handles.calibratethrubutton,'visible','off')
set(handles.calibrateisolationbutton,'visible','off')
set(handles.restartcalibratingbutton,'visible','off')
set(handles.savestatusandcalibrationbutton,'visible','off')
