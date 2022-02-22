%--------------------------------------------------------------------------
%
%
%                         Balance measurements
%
%
%--------------------------------------------------------------------------
% @ Victor Mangeleer
% @ Arnaud Rémi
%
%--------------
% Documentation
%--------------
% This script has for purpose to measure the evolution of the mass using
% the balance available in the laboratory
%
% Note : Use appdesigner to create user interface
%
clear;
addpath('Functions/');
%--------------------------------------------------------------------------
%
%                              Balance Parameters
%
%--------------------------------------------------------------------------
% Define communicating port
COM = "COM6";

% Saving rate (Time spend between each save of measure) [s]
s_rate = 2;

% Measurement duration [s]
m_duration = 140;

% Information over terminal
balance_terminal(0, COM, s_rate, m_duration);
%--------------------------------------------------------------------------
%
%                                Measurements
%
%--------------------------------------------------------------------------
% Computation of number of iterations for measurements
m_iterations = m_duration/s_rate;

% GUI interface for the continous measurement
hWaitbar = waitbar(0, 'Measurement : 0', 'Name', 'Balance', ...
                   'CreateCancelBtn','delete(gcbf)');
% Measuring mass
for i = 1 : m_iterations

    bool = input("Press 1 to make a measurement, press 0 to stop : ");
    
    if bool == 1
        % Opening the port
        s_port = serialport(COM, 9600, 'Parity', 'None', 'DataBits', 8, ...
                           'FlowControl', 'none', 'StopBits', 1, 'Timeout', 6); 

        % Reading mass over the balance
        k = 1;
        while k == 1 || strlength(readline(s_port)) < 7
            m = readline(s_port);
            k = k + 1;
        end

        % Retrieving time of measurement
        [t, ~] = clock;
        hour = t(4); min = t(5); sec = t(6);

        % Saving mass and time
        mass(i) = m;
        time(i) = hour * 3600 + min * 60 + sec;

        % GUI Interface
        drawnow;

        % Stops measurement if cancel button is pressed
        if ~ishandle(hWaitbar)
            break;
        else
            % Update the wait bar
            waitbar(i/m_iterations, hWaitbar, ['Measurement : ' num2str(i)]);
        end

        % Closing the port
        clear s_port;

        % Waiting time between each save
        % pause(s_rate);
    elseif bool == 0
        break;
    end
end

% Information over terminal
balance_terminal(1, COM, s_rate, m_duration);
%--------------------------------------------------------------------------
%
%                             Data saving
%
%--------------------------------------------------------------------------
% Closing the GUI interface and port (if needed)
if exist('hWaitbar','var') == 1
    close(hWaitbar);
end

if exist('s_port','var') == 1
    clear(s_port)
end

% Converting to the reference 0
time = time - ones(size(time)) * time(1);

% Creating .txt file name
nb_data   = {dir("../Experiments/Initial/Data/").name};
nb_data   = length(nb_data(~strncmp(nb_data, '.', 1))) + 1;
data_name = "Experiment_" + int2str(nb_data);

% Convert table/string array into double array
mass = string(mass{1,:});
mass = erase(mass,'?');
mass = str2double(mass);

% Creating table of data
Data_table = table(time',mass','VariableNames', { 'Time [s]', 'Mass [g]'});

% Saving the table inside data folder
writetable(Data_table, '../Experiments/Initial/Data/' + data_name);

% Information over terminal
balance_terminal(2, COM, s_rate, m_duration);

