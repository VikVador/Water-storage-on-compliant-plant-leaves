%--------------------------------------------------------------------------
%
%
%                             Image Processing
%
%
%--------------------------------------------------------------------------
% @ Victor Mangeleer
% @ Arnaud Rémi
%
%--------------
% Documentation
%--------------
% This script has for purpose to shape as well as to process all the images 
% obtained during our experiments. In order to use it, one must place in 
% the folder "Experiments" all the raw data.
%
addpath('Functions/');
%--------------------------------------------------------------------------
%
%                              Script Parameters
%
%--------------------------------------------------------------------------
% Run the script on debug mode (See step by step processing)
debug_mode = false;

% Run the script to determine the cropping position
cropping_mode =  false;

% Information over the terminal
img_terminal(1, false);
%--------------------------------------------------------------------------
%
%                           Processing Parameters
%
%--------------------------------------------------------------------------
% Resizing factor
rz = 1;

% Threshold value
trsh = 30;

% Filter intensity
flt = 5;

% Cropping position
cp = [2999.5 1955.5 713 1494];

% Information over the terminal
img_terminal(2, cropping_mode);
%--------------------------------------------------------------------------
%
%                              Loading files
%
%--------------------------------------------------------------------------
% Load all the images, backgrounds, reference and paths
img_loading;

% Information over the terminal
img_terminal(3, cropping_mode);

%--------------------------------------------------------------------------
%
%                          Cropping determination
%
%--------------------------------------------------------------------------
if(cropping_mode == true)

    % Enters cropping mode to determine cropping box dimensions
    img_shaped = imresize(imread(PTS_background) , rz);
    img_shaped = imcrop(img_shaped);

    % Stopping the script
    return

end
%--------------------------------------------------------------------------
%
%                                 Shaping
%
%--------------------------------------------------------------------------
% Shaping the background
img_shaping(PTS_background, PTS_background_s, rz, cp)

% Shaping the photos
for i = 1 : length(Photos_raw_names)

    % Path to the raw image
    img_raw_path = Photos_raw + Photos_raw_names{i};

    % Path to the image's save
    img_shaped_path = Photos_shaped + Photos_raw_names{i};

    % Shaping the image
    img_shaping(img_raw_path, img_shaped_path, rz, cp);

end

% Information over the terminal
img_terminal(4, cropping_mode);
%--------------------------------------------------------------------------
%
%                                  Processing
%
%--------------------------------------------------------------------------
for i = 1 : length(Photos_raw_names)

    % Path to the image's save
    img_shaped_path = Photos_shaped + Photos_raw_names{i};

    % Path to the processed image
    img_processed_path = Photos_final + Photos_raw_names{i};

    % Processing
    img_processing(PTS_background_s, img_shaped_path, ...
                   img_processed_path, trsh, flt, debug_mode)
end

% Information over the terminal
img_terminal(5, cropping_mode);
