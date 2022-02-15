%--------------------------------------------------------------------------
%
%
%                           Image Analysis
%
%
%--------------------------------------------------------------------------
% @ Victor Mangeleer
% @ Arnaud Rémi
%
%--------------
% Documentation
%--------------
% This script has for purpose to measure angle of curvature alpha as well
% as the associated stiffness of the leaf
%
addpath('Functions/');
%--------------------------------------------------------------------------
%
%                              Script Parameters
%
%--------------------------------------------------------------------------
% Run the script to determine the cropping position
cropping_mode =  false;

% Automatic cropping
auto_crop = true;

%--------------------------------------------------------------------------
%
%                           Processing Parameters
%
%--------------------------------------------------------------------------
% Cropping position
cp = [33.5 3.5 288 103];

% Length of the leaf [m]
L = 0.03;

%--------------------------------------------------------------------------
%
%                              Loading files
%
%--------------------------------------------------------------------------
% Processed pictures
Photos_proc = {dir("../Experiments/Final/Photos/").name};
Photos_proc = Photos_proc(~strncmp(Photos_proc, '.', 1));

% Raw data
Data_raw_names   = {dir("../Experiments/Initial/Data/").name};
Data_raw_names = Data_raw_names(~strncmp(Data_raw_names, '.', 1));

% Processed path
Processed_path = "../Experiments/Final/";

% Information over the terminal
img_anal_terminal(0, cropping_mode);
%--------------------------------------------------------------------------
%
%                           Cropping position
%
%--------------------------------------------------------------------------
if(cropping_mode == true)

    % Enters cropping mode to determine cropping box dimensions
    img_shaped = imcrop(imread(Processed_path + "Photos/" + ...
                        Photos_proc(1)));

    % Stopping the script
    return

end
%--------------------------------------------------------------------------
%
%                            Choosing dataset
%
%--------------------------------------------------------------------------
% Selection of a data set
disp("-------");
disp("Dataset");
disp("-------");
disp(" ");
for i = 1 : length(Data_raw_names)
    disp(num2str(i) + " - " + Data_raw_names(i))
    disp(" ");
end
nb_data = input("Select the dataset : ");
disp(" ");

% Loading the data
Data = readtable("../Experiments/Initial/Data/" + Data_raw_names(nb_data));

% Loading the time vector
Time = table2array(Data(:, 1));

% Loading the mass vector
Mass = table2array(Data(:, 2));

% Information over the terminal
img_anal_terminal(2, cropping_mode);
%--------------------------------------------------------------------------
%
%                          Computing the angle
%
%--------------------------------------------------------------------------
% Contains the angles
alpha_low  = zeros(length(Photos_proc), 1);
alpha_mean = zeros(length(Photos_proc), 1);
alpha_high = zeros(length(Photos_proc), 1);

% Contains the angles
RMSE_low  = zeros(length(Photos_proc), 1);
RMSE_mean = zeros(length(Photos_proc), 1);
RMSE_high = zeros(length(Photos_proc), 1);

% Contains the stiffness
stiffness_low  = zeros(length(Photos_proc), 1);
stiffness_mean = zeros(length(Photos_proc), 1);
stiffness_high = zeros(length(Photos_proc), 1);

% Looping over the images
for i = 1 : length(Photos_proc)
    
    % Loading the image
    image = imread(Processed_path + "Photos/" + Photos_proc(i));

    % Croppping the image
    if auto_crop == true
        image = imcrop(image, cp);
    else
        image = imcrop(image);
    end

    [alpha_LOW, alpha_MEAN, alpha_HIGH, RMSE_LOW, RMSE_MEAN, RMSE_HIGH] ...
    = img_alphas(image);

    % Storing the values
    alpha_low(i)  = alpha_LOW; alpha_mean(i) = alpha_MEAN;
    alpha_high(i) = alpha_HIGH; RMSE_low(i)    = RMSE_LOW;
    RMSE_mean(i)   = RMSE_MEAN; RMSE_high(i)   = RMSE_HIGH;

    % Computing the different stifness
    stiffness_low(i)  = get_stiffness(alpha_LOW, Mass(i), L, 9.81);
    stiffness_mean(i) = get_stiffness(alpha_MEAN, Mass(i), L, 9.81);
    stiffness_high(i) = get_stiffness(alpha_HIGH, Mass(i), L, 9.81);

end
% Information over the terminal
img_anal_terminal(3, cropping_mode);

% --------------------------------------------------------------------------
%
%                          Saving all the data
%
%--------------------------------------------------------------------------
Data_table = table(Time, Mass, alpha_low, alpha_mean, alpha_high, ...
                         RMSE_low, RMSE_mean, RMSE_high, ...
                         stiffness_low, stiffness_mean, stiffness_high, ...
                         'VariableNames', {'Time', 'Mass', 'Alpha low', ...
                         'Alpha mean', 'Alpha high', 'RMSE low', ...
                         'RMSE mean', 'RMSE high', 'k low', ...
                         'k mean', 'k high'});

% Saving the table inside the final data folder
writetable(Data_table, Processed_path + "Data/" + Data_raw_names(nb_data));

% Information over the terminal
img_anal_terminal(4, cropping_mode);







