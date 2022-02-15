%--------------------------------------------------------------------------
%
%
%                             Data Analysis
%
%
%--------------------------------------------------------------------------
% @ Victor Mangeleer
% @ Arnaud Rémi
%
%--------------
% Documentation
%--------------
% This script has for purpose to plot all the data of
% each experiment against one another !
%
clc; close all;
%
addpath('Functions/');
%--------------------------------------------------------------------------
%
%                            Choosing dataset
%
%--------------------------------------------------------------------------
% Raw data
Data_raw_names   = {dir("../Experiments/Final/Data/").name};
Data_raw_names = Data_raw_names(~strncmp(Data_raw_names, '.', 1));

%----------------------
% Evolution of the mass
%----------------------
figure;
for i = 1 : length(Data_raw_names)

    % Loading the data
    Data = readtable("../Experiments/Final/Data/" + Data_raw_names(i));

    % Loading the time vector
    Time = table2array(Data(:, 1));

    % Loading the mass vector
    Mass = table2array(Data(:, 2));

    % Plotting the results
    plot(Time, Mass, 'v', 'linewidth', 1.5);
    hold on;
    
    
end
grid on;
legend(Data_raw_names);
xlabel('Time [s]', 'Fontsize', 25, 'interpreter', 'latex');
ylabel('Mass [g]', 'Fontsize', 25, 'interpreter', 'latex');
set(gca,'Fontsize', 15);

%------------------------------
% Evolution of the angles - Low
%------------------------------
figure;
for i = 1 : length(Data_raw_names)

    % Loading the data
    Data = readtable("../Experiments/Final/Data/" + Data_raw_names(i));

    % Loading the time vector
    Time = table2array(Data(:, 1));

    % Loading the mass vector
    alpha_low = table2array(Data(:, 3));

    % Plotting the results
    plot(Time, alpha_low, 'v', 'linewidth', 1.5);
    hold on;
end
grid on;
legend(Data_raw_names);
xlabel('Time [s]', 'Fontsize', 25, 'interpreter', 'latex');
ylabel('$\alpha_{low}$', 'Fontsize', 25, 'interpreter', 'latex');
set(gca,'Fontsize', 15);

%-------------------------------
% Evolution of the angles - Mean
%-------------------------------
figure;
for i = 1 : length(Data_raw_names)

    % Loading the data
    Data = readtable("../Experiments/Final/Data/" + Data_raw_names(i));

    % Loading the time vector
    Time = table2array(Data(:, 1));

    % Loading the mass vector
    alpha_mean = table2array(Data(:, 4));

    % Plotting the results
    plot(Time, alpha_mean, 'v', 'linewidth', 1.5);
    hold on;
end
grid on;
legend(Data_raw_names);
xlabel('Time [s]', 'Fontsize', 25, 'interpreter', 'latex');
ylabel('$\alpha_{mean}$', 'Fontsize', 25, 'interpreter', 'latex');
set(gca,'Fontsize', 15);

%-------------------------------
% Evolution of the angles - High
%-------------------------------
figure;
for i = 1 : length(Data_raw_names)

    % Loading the data
    Data = readtable("../Experiments/Final/Data/" + Data_raw_names(i));

    % Loading the time vector
    Time = table2array(Data(:, 1));

    % Loading the mass vector
    alpha_high = table2array(Data(:, 5));

    % Plotting the results
    plot(Time, alpha_high, 'v', 'linewidth', 1.5);
    hold on;
end
grid on;
legend(Data_raw_names);
xlabel('Time [s]', 'Fontsize', 25, 'interpreter', 'latex');
ylabel('$\alpha_{high}$', 'Fontsize', 25, 'interpreter', 'latex');
set(gca,'Fontsize', 15);

%-----------------------------------
% Evolution of the angles - RMSE low
%-----------------------------------
figure;
for i = 1 : length(Data_raw_names)

    % Loading the data
    Data = readtable("../Experiments/Final/Data/" + Data_raw_names(i));

    % Loading the time vector
    Time = table2array(Data(:, 1));

    % Loading the mass vector
    RMSE_low = table2array(Data(:, 6));

    % Plotting the results
    plot(Time, RMSE_low, 'v', 'linewidth', 1.5);
    hold on;
end
grid on;
legend(Data_raw_names);
xlabel('Time [s]', 'Fontsize', 25, 'interpreter', 'latex');
ylabel('$RMSE_{low}$', 'Fontsize', 25, 'interpreter', 'latex');
set(gca,'Fontsize', 15);

%-----------------------------------
% Evolution of the angles - RMSE low
%-----------------------------------
figure;
for i = 1 : length(Data_raw_names)

    % Loading the data
    Data = readtable("../Experiments/Final/Data/" + Data_raw_names(i));

    % Loading the time vector
    Time = table2array(Data(:, 1));

    % Loading the mass vector
    RMSE_mean = table2array(Data(:, 7));

    % Plotting the results
    plot(Time, RMSE_mean, 'v', 'linewidth', 1.5);
    hold on;
end
grid on;
legend(Data_raw_names);
xlabel('Time [s]', 'Fontsize', 25, 'interpreter', 'latex');
ylabel('$RMSE_{mean}$', 'Fontsize', 25, 'interpreter', 'latex');
set(gca,'Fontsize', 15);

%-----------------------------------
% Evolution of the angles - RMSE high
%-----------------------------------
figure;
for i = 1 : length(Data_raw_names)

    % Loading the data
    Data = readtable("../Experiments/Final/Data/" + Data_raw_names(i));

    % Loading the time vector
    Time = table2array(Data(:, 1));

    % Loading the mass vector
    RMSE_high = table2array(Data(:, 8));

    % Plotting the results
    plot(Time, RMSE_high, 'v', 'linewidth', 1.5);
    hold on;
end
grid on;
legend(Data_raw_names);
xlabel('Time [s]', 'Fontsize', 25, 'interpreter', 'latex');
ylabel('$RMSE_{high}$', 'Fontsize', 25, 'interpreter', 'latex');
set(gca,'Fontsize', 15);

% Information over the terminal
pause(1);
clc;
disp("------------------------------------------------------------------");
disp(" ");
disp("                           Data Analysis                          ");
disp(" ");
disp("------------------------------------------------------------------");
disp(" ");
disp("Plotting the results : Done");
disp(" ");









