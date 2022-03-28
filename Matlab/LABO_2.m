%--------------------------------------------------------------------------
%
%                             Laboratory 2
%                         
%                         Evolution of mu(k)
%
%--------------------------------------------------------------------------
% @ Victor Mangeleer
% @ Arnaud Rémi
%
clc;
%--------------------------------------------------------------------------
%                               Documentation
%--------------------------------------------------------------------------
disp("------------------------------------------------------------------");
disp(" ");
disp("                            Laboratory 2                          ");
disp(" ");
disp("                          Evolution of mu(k)                      ");
disp(" ");
disp("------------------------------------------------------------------");
disp("In order to make the graph of mu(k), you must follow these steps :");
disp(" ");
disp(" 1 - In Experiments/Initial/Videos/, you must place a video named ");
disp("     Background.MOV as well as the other videos which are simply  ");
disp("     videos of a few second (used to determine k0).               ");
disp(" ");
disp(" 2 - The background as well as the videos must be extracted from  ");
disp("     the videos using the first frame.                            ");
disp(" ");
disp(" 3 - The background and the frame must be processed.              ");
disp(" ");
disp(" 4 - The experiment can start with the balance."                   );
disp(" ");
disp(" 5 - The stiffness can be computed.                               ");
disp(" ");
disp(" 6 - The results can be plotted.                                  ");
disp(" ");
disp("------------------------------------------------------------------");
disp("                              List of actions                     ");
disp("------------------------------------------------------------------");
disp(" 1 - WAIT");
disp(" ");
disp(" 2 - EXTRACTING BACKGROUND AND VIDEO");
disp(" ");
disp(" 3 - PROCESSING BACKGROUND AND VIDEO");
disp(" ");
disp(" 4 - BALANCE");
disp(" ");
disp(" 5 - COMPUTING DATA");
disp(" ");
disp(" 6 - PLOTTING  DATA");
disp(" ");
action = input("Action to take : ");

%--------------------------------------------------------------------------
%                                    Code
%--------------------------------------------------------------------------
if(action == 2)
    Background_Processing;
    clc;
    Video_Processing;
end

if(action == 3)
    Image_Processing;
end

if(action == 4)
    Balance;
end

if(action == 5)
    Image_Analysis;
end

if(action == 6)
    Data_Analysis;
end









