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
cp = [1034.5 392.5 1263 582];

% Length of the leaf (NEED TO BE COMPUTED EXPERIMENTALLY) [m]
L = 0.01;

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

% Loading the mass vector
Mass = table2array(Data(:, 2));

%--------------------------------------------------------------------------
%
%                          Computing the angle
%
%--------------------------------------------------------------------------
% Contains the angles
alpha_low  = zeros(length(Photos_proc), 1);
alpha_mean = zeros(length(Photos_proc), 1);
alpha_high = zeros(length(Photos_proc), 1);

% Contains the stiffness
stiffness_low  = zeros(length(Photos_proc), 1);
stiffness_mean = zeros(length(Photos_proc), 1);
stiffness_high = zeros(length(Photos_proc), 1);

% Looping over the images
for i = 1 : length(Photos_proc)
    
    % Loading the image
    image = imread(Processed_path + Photos_proc(i));

    % Croppping the image
    if auto_crop == true
        image = imcrop(image, cp);
    else
        image = imcrop(image);
    end

    % Dimensions of the image
    [n_rows, n_coll] = size(image);

    % Allocation storage vectors for dy and dx
    x = zeros(n_coll, 1);
    y_low  = NaN(n_coll, 1);
    y_high = NaN(n_coll, 1);

    % Finding dy and dx
    for j = 1 : n_coll

        % Checks if a portion of the leaf is visible in the column
        if ~isempty(find(image(:,j) ~= 0, 1))

            % Bottom of the leaf
            y_low(j)  = find(image(:,j) ~= 0, 1, 'last');

            % Top of the leafs
            y_high(j) = find(image(:,j) ~= 0, 1);

            % Update of the horizontal position
            x(j) = j;
        end
    end

    % Computing dy and dx
    dy_low = min(y_low) - max(y_low);
    dy_high = min(y_high) - max(y_high);
    dx = find(x ~= 0, 1, 'last') - find(x ~= 0, 1);

    % Computing the corresponding angles
    alpha_low(i)  = atan(dy_low/dx);
    alpha_high(i) = atan(dy_high/dx);
    alpha_mean(i) = 0.5 * (alpha_high(i) + alpha_low(i));

    % Computing the different stifness
    stiffness_low(i)  = get_stiffness(alpha_low(i), Mass(i), L, 9.81);
    stiffness_high(i) = get_stiffness(alpha_high(i), Mass(i), L, 9.81);
    stiffness_mean(i) = 0.5 * (stiffness_low(i)  + stiffness_high(i));
end

%--------------------------------------------------------------------------
%
%                          Saving all the data
%
%--------------------------------------------------------------------------
Data_table = table(Mass, alpha_low, stiffness_low, ...
                         alpha_mean, stiffness_mean, ...
                         alpha_high, stiffness_high, 'VariableNames', ...
                         {'m', 'alpha_low', 'k_low', ...
                               'alpha_mean', 'k_mean', ...
                               'alpha_high', 'k_high'});

% Saving the table inside the final data folder
writetable(Data_table, Processed_path + "Data/" + Data_raw_names(nb_data));








