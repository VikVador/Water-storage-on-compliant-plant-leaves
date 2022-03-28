%--------------------------------------------------------------------------
%
%
%                             Video Processing
%
%
%--------------------------------------------------------------------------
% @ Victor Mangeleer
% @ Arnaud Rémi
%
%--------------
% Documentation
%--------------
% This script has for purpose to retreive the first frame of the video
%
addpath('Functions/');

% Cleaning the previous run
vd_cleaning;

% Information over the terminal
vd_terminal(0);
%--------------------------------------------------------------------------
%
%                              Loading files
%
%--------------------------------------------------------------------------
% Load the path of the data and videos
Videos_raw_names = {dir("../Experiments/Initial/Videos/").name};

% Remove useless files
Videos_raw_names = Videos_raw_names(~strncmp(Videos_raw_names, '.', 1));

% Checks videos availability
if isempty(Videos_raw_names)
    disp("The video folder is empty.");
    disp(" ");
    return;
end

%--------------------------------------------------------------------------
%
%                       Choosing video and dataset
%
%--------------------------------------------------------------------------
% Selection of a video
disp("------");
disp("Videos");
disp("------");
disp(" ");
for i = 1 : length(Videos_raw_names)
    disp(num2str(i) + " - " + Videos_raw_names(i))
    disp(" ");
end
nb_video = input("Select the video : ");

% Information over the terminal
vd_terminal(0);

% Information over the terminal
vd_terminal(1);
%--------------------------------------------------------------------------
%
%                           Processing the video
%
%--------------------------------------------------------------------------
% Opening the video
vidObj = VideoReader("../Experiments/Initial/Videos/" + ...
                     Videos_raw_names(nb_video));
 
% Number of the frame used
f_index = 1;

% Retrieving the image
f = read(vidObj, f_index);

% Creation of the file name
filename2 = strcat('Frame', num2str(f_index),'.jpg');

% Saving the frame
imwrite(f, "../Experiments/Initial/Photos/" + filename2);

% Information over the terminal
vd_terminal(2);