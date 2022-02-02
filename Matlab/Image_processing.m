%--------------------------------------------------------------------------
%
%                            Image processing
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
% the folder "Experiments/Initial/..." all the raw data.
%
% Information on the terminal
img_terminal(1);
%--------------------------------------------------------------------------
%                                 Parameters
%--------------------------------------------------------------------------
%--------
% Surface
%--------
% Resizing
rz_s = 0.5;

% Crop position
cp_s = [293.5 322.5 1532 1023];

% Threshold
trsh_s = 40;

% Filter
flt_s = 5;

%----------
% Curvature
%----------
% Resizing 
rz_c = 0.5;

% Crop position
cp_c = [293.5 322.5 1532 1023];

% Threshold
trsh_c = 40;

% Filter
flt_c = 10;

% Information on the terminal
img_terminal(2);
%--------------------------------------------------------------------------
%                              Loading files
%--------------------------------------------------------------------------
% Load all the images, backgrounds, reference and paths
img_loading;

% Information on the terminal
img_terminal(3);
%--------------------------------------------------------------------------
%                                 Shaping
%--------------------------------------------------------------------------
% Backgrounds and reference (Saving at the same spot)
img_shaping(S_ref_name, S_ref_save, rz_s, cp_s)
img_shaping(S_bkg_name, S_bkg_save, rz_s, cp_s)
img_shaping(C_bkg_name, C_bkg_save, rz_c, cp_c)

% Surface
for i = 1 : length(S_raw_name)

    % Path to the raw image
    img_raw_path = S_raw + S_raw_name{i};

    % Path to the image's save
    img_shaped_path = S_save + S_raw_name{i};

    % Shaping the image
    img_shaping(img_raw_path, img_shaped_path, rz_s, cp_s);

end

% Curvature
for i = 1 : length(C_raw_name)

    % Path to the raw image
    img_raw_path = C_raw + C_raw_name{i};

    % Path to the image's save
    img_shaped_path = C_save + C_raw_name{i};

    % Shaping the image
    img_shaping(img_raw_path, img_shaped_path, rz_c, cp_c);

end

% Information on the terminal
img_terminal(4);
%--------------------------------------------------------------------------
%                                  Processing
%--------------------------------------------------------------------------
% Surfaces
for i = 1 : length(S_raw_name)

    % Path to the image's save
    img_shaped_path = S_save + S_raw_name{i};

    % Path to the processed image
    img_processed_path = S_final + S_raw_name{i};

    % Processing
    img_processing(S_bkg_save, img_shaped_path, img_processed_path, ...
                   trsh_s, flt_s)
end

% Surfaces
for i = 1 : length(C_raw_name)

    % Path to the image's save
    img_shaped_path = C_save + C_raw_name{i};

    % Path to the processed image
    img_processed_path = C_final + C_raw_name{i};

    % Processing
    img_processing(C_bkg_save, img_shaped_path, img_processed_path, ...
                   trsh_c, flt_c)
end

% Information on the terminal
img_terminal(5);
%--------------------------------------------------------------------------
%                        Computing the reference
%--------------------------------------------------------------------------
% Process the reference image and determine the number of pixels per cm^2
ref_value = img_ref(S_bkg_save, S_ref_save);

% Information on the terminal
img_terminal(6);
%--------------------------------------------------------------------------