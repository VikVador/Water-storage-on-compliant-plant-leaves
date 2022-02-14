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
% This script has for purpose retrieve all the frames corresponding
% to the time vector of each mass measurement made during the experiments
%
addpath('Functions/');

% Information over the terminal
vd_terminal(0);
%--------------------------------------------------------------------------
%
%                              Loading files
%
%--------------------------------------------------------------------------
% Load the path of the data and videos
Data_raw_names   = {dir("../Experiments/Initial/Data/").name};
Videos_raw_names = {dir("../Experiments/Initial/Videos/").name};

% Remove useless files
Data_raw_names = Data_raw_names(~strncmp(Data_raw_names, '.', 1));
Videos_raw_names = Videos_raw_names(~strncmp(Videos_raw_names, '.', 1));

% Checks videos availability
if isempty(Videos_raw_names)
    disp("The video folder is empty.");
    disp(" ");
    return;
end

% Checks data availability
if isempty(Data_raw_names)
    disp("The data folder is empty.");
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

% Information over the terminal
vd_terminal(1);
%--------------------------------------------------------------------------
%
%                           Processing the video
%
%--------------------------------------------------------------------------
% Loading the data
Data = readtable("../Experiments/Initial/Data/" + Data_raw_names(nb_data));

% Loading the time vector
Time = table2array(Data(:, 1));

% Opening the video
vidObj = VideoReader("../Experiments/Initial/Videos/" + ...
                     Videos_raw_names(nb_video));

% Conversion between time and frames
u = round(vidObj.FrameRate * Time);

% Correction of the first frame
u(1) = 1;
 
% Index for frame numbering
f_index = 1;

% Creation of the corresponding images
for img = 1 : length(u)

    % Creation of the file name
    filename2 = strcat('Frame', num2str(f_index),'.jpg');
    f_index = f_index + 1;

    % Retrieving the frame
    f = read(vidObj, u(img));

    % Saving the frame
    imwrite(f, "../Experiments/Initial/Photos/" + filename2);
end

% Information over the terminal
vd_terminal(2);