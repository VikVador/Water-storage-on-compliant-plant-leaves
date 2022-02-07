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
% This script has for purpose to compute the curvature angle of the leaf
%
%--------------------------------------------------------------------------
%                                 Parameters
%--------------------------------------------------------------------------
% Choose to run the script on auto-pilot or not
automatic = true;

% Crop position
cp_c = [293.5 322.5 1532 1023];

%--------------------------------------------------------------------------
%                              Loading files
%--------------------------------------------------------------------------
% Load all the images, backgrounds, reference and paths
img_loading;

%--------------------------------------------------------------------------
%                                 Croping
%--------------------------------------------------------------------------

    
    % Cropping the image
    img_shaped = imcrop(img_shaped, crop);