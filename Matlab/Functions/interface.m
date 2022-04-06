%--------------------------------------------------------------------------
%
%                           BALANCE INTERFACE
%
%--------------------------------------------------------------------------
%
%--------------------------------------------------------------------------
%                             DO NOT TOUCH
%--------------------------------------------------------------------------
function varargout = interface(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @interface_OpeningFcn, ...
                   'gui_OutputFcn',  @interface_OutputFcn, ...
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
%--------------------------------------------------------------------------
%                               FUNCTIONS
%--------------------------------------------------------------------------
%
% --- Executes just before interface is made visible.
%
function interface_OpeningFcn(hObject, eventdata, handles, varargin)

% Choose default command line output for interface
handles.output = hObject;

%------------
% Parameters
%------------
% Saving rate for the measurements [Measurments/s]
S_RATE = 1;

% Define communicating port
COM = "/dev/tty.usbserial-FT3QPO3F";

% Initialization of button
handles.MEASURE = 0;

% Update handles structure
guidata(hObject, handles);

% Creation of the plot -> plot(hh,randn(50))
hh = handles.axes1;

% Showing the figure
handles.figure1.Visible = 'on';

% Index for measurements
index = 1;

%-------------------
% Measurement state
%-------------------
while true

    % Update of the handle
    handles = guidata(hObject);
    
    % MEASUREMENT
    if handles.MEASURE == 1
        
        % Opening the port
        s_port = serialport(COM, 9600, 'Parity', 'None', ... 
                            'DataBits', 8, 'FlowControl', 'none', ...
                            'StopBits', 1, 'Timeout', 6); 
        
        % Reading, cleaning and saving mass value
        m = readline(s_port);
        m = erase(m," ");
        m = erase(m,"g");
        m = erase(m,"s");
        m = erase(m,"S");
        m = str2double(m);
        mass(index)    = m;

        % Removing the port
        clear s_port;

        % Update index value
        index_v(index) = index;

        % Plotting the results
        plot(hh, index_v, mass, '-o', "LineWidth", 12);
        xlabel("Number of the measurement [-]");
        ylabel("Mass [g]");
        set(gca, 'fontsize', 24, 'fontname', 'Times', 'LineWidth', 0.5);
        grid on;
        
        % Updating index
        index = index + 1;
    end
        
    % STOPPING
    if handles.MEASURE == -1
        hold on;
        yline(max(mass));
        break;
    end

    uiwait(handles.figure1, S_RATE);
end

% Create a table with the data and variable names
T = table(max(mass), 'VariableNames', {'Mass'});
writetable(T, 'MASS.txt')

% Displaying the max value
disp("Masse Critique = " + string(max(mass)));

%--------------------------------------------------------------------------
%                               BUTTONS
%--------------------------------------------------------------------------
%
% --- Outputs from this function are returned to the command line.
%
function varargout = interface_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;

%
% --- Executes on button press in start.
%
function start_Callback(hObject, eventdata, handles)

% Changing to measurement state
handles.MEASURE = 1;

% Updating handles
guidata(hObject, handles);

%
% --- Executes on button press in stop.
%
function stop_Callback(hObject, eventdata, handles)

% Changing to measurement state
handles.MEASURE = -1;

% Updating handles
guidata(hObject, handles);

%
% --- Executes on button press in reset.
%
function reset_Callback(hObject, eventdata, handles)

% Changing to measurement state
handles.MEASURE = -2;

% Updating handles
guidata(hObject, handles);
