%--------------------------------------------------------------------------
%
%
%                          Background Processing
%
%
%--------------------------------------------------------------------------
% @ Victor Mangeleer
% @ Arnaud Rémi
%
%--------------
% Documentation
%--------------
% This script has for purpose retrieve all the frames corresponding
% to the time vector of each mass measurement made during the experiments
%
addpath('Functions/');

% Information over the terminal
%--------------------------------------------------------------------------
%
%                              Loading files
%
%--------------------------------------------------------------------------
% Load the path of the data and videos
Videos_raw_names = {dir("../Experiments/Initial/Videos/").name};

% Remove the undesired files
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


% Opening the video
vidObj = VideoReader("../Experiments/Initial/Videos/" + ...
                     Videos_raw_names(nb_video));

% Creation of the file name
filename2 = strcat('Background','.jpg');

% Retrieving the frame
f = read(vidObj, 1);

% Saving the frame
imwrite(f, "../Experiments/Initial/Background/" + filename2);
