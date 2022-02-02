%--------------------------------------------------------------------------
%                             Image terminal
%--------------------------------------------------------------------------
% @ Victor Mangeleer
% @ Arnaud Rémi
%
function img_terminal(step)
%--------------
% Documentation
%--------------
% Simple function to display information about the image processing
%
% Before running the script
clc;
if(step == 1)
    disp("-------------------------------------------------------");
    disp("                     Image Processing                  ");
    disp("-------------------------------------------------------");
    disp(" ");
    disp("ATTENTION : Make sur to possess an original copy of the");
    disp("            data before going further. Press any button");
    disp("            to run the script.")
    pause;
    close all;
end

% Running the script
if(step > 1)
    clc;
    disp("-------------------------------------------------------");
    disp("                     Image Processing                  ");
    disp("-------------------------------------------------------");
    disp(" ");
    if step > 2
        disp("Loading files       : Done")
    else
        disp("Loading files       : ...")
    end

    disp(" ");

    if step > 3
        disp("Shaping images      : Done")
    else
        disp("Shaping images      : ...")
    end

    disp(" ");

    if step > 4
        disp("Processing images   : Done")
    else
        disp("Processing images   : ...")
    end
    disp(" ");

    if step > 5
        disp("Computing reference : Done")
    else
        disp("Computing reference : ...")
    end
    disp(" ");

end
end






