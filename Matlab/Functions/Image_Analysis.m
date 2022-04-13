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
function [alpha_0, alpha_0_error, k_0] = Image_Analysis(m, l)

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
cp = [24.5 22.5 748 528];

% Length of the leaf [m]
L = l;

% Mass of the leaf
Mass = m;

%--------------------------------------------------------------------------
%
%                              Loading files
%
%--------------------------------------------------------------------------
% Processed pictures
Photos_proc = {dir("../Experiments/Final/Photos/").name};
Photos_proc = Photos_proc(~strncmp(Photos_proc, '.', 1));

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

% Information over the terminal
img_anal_terminal(2, cropping_mode);
%--------------------------------------------------------------------------
%
%                          Computing the angle
%
%--------------------------------------------------------------------------
% Contains the angles
alpha_0  = 0;

% Contains the error on the angles
alpha_0_error = 0;

% Contains the stiffness
k_0  = 0;

% Looping over the images
for i = 1 : length(Photos_proc)
    
    % Loading the image
    image = imread(Processed_path + "Photos/" + Photos_proc(i));

    % Croppping the image
    %if auto_crop == true
    %    image = imcrop(image, cp);
    %else
    %    image = imcrop(image);
    %end

    [alpha_LOW, alpha_MEAN, alpha_HIGH, RMSE_LOW, RMSE_MEAN, RMSE_HIGH] ...
    = img_alphas(image);

    % Storing the values
    alpha_0  = abs(alpha_LOW);
    alpha_0_error = RMSE_LOW; 
    
    % Computing the different stifness
    k_0  = get_stiffness(alpha_0, Mass, L, 9.81);
end

% Information over the terminal
img_anal_terminal(3, cropping_mode);

% Information over the terminal
img_anal_terminal(4, cropping_mode);

end




