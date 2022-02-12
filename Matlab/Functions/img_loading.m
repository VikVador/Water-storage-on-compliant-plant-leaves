%--------------------------------------------------------------------------
%
%                             Image loading
%
%--------------------------------------------------------------------------
% @ Victor Mangeleer
% @ Arnaud Rémi
%
%--------------
% Documentation
%--------------
% This script has for purpose to load all the path needed to load and save
% the images processed by the script "Image_Processing"

% Folders' path
Photos_raw    = "../Experiments/Initial/Photos/";
Photos_shaped = "../Experiments/____/Photos_shaped/";
Photos_final  = "../Experiments/Final/Photos/";

PTS_background   = "../Experiments/Initial/Background/Background.JPG";
PTS_background_s = "../Experiments/____/Background_shaped/Background.JPG";

% Removing useless files
Photos_raw_names = {dir("../Experiments/Initial/Photos/").name};
Photos_raw_names = Photos_raw_names(~strncmp(Photos_raw_names, '.', 1));