%--------------------------------------------------------------------------
%                          Image Analysis terminal
%--------------------------------------------------------------------------
% @ Victor Mangeleer
% @ Arnaud Rémi
%
function img_anal_terminal(step, crop)
    %--------------
    % Documentation
    %--------------
    % Display information about the image processing

    clc;

    if(crop == true)
        disp("-------------------------------------------------------");
        disp(" ")
        disp("                     Image Analysis                  ");
        disp(" ")
        disp("-------------------------------------------------------");
        disp(" ")
        disp("The script is running in 'cropping determination' mode")
        disp(" ")

        return;
    end

    if(step == 1)
        disp("-------------------------------------------------------");
        disp(" ")
        disp("                     Image Analysis                  ");
        disp(" ")
        disp("-------------------------------------------------------");
    end


    if(step == 2)
        disp("-------------------------------------------------------");
        disp(" ")
        disp("                     Image Analysis                  ");
        disp(" ")
        disp("-------------------------------------------------------");
        disp(" ");
        disp("Computation of the angles and stifness : ...")
        disp(" ")
        disp("Saving the data                        : ...")
        disp(" ")
    end


    if(step == 3)
        disp("-------------------------------------------------------");
        disp(" ")
        disp("                     Image Analysis                  ");
        disp(" ")
        disp("-------------------------------------------------------");
        disp(" ");
        disp("Computation of the angles and stifness : Done")
        disp(" ")
        disp("Saving the data                        : ...")
        disp(" ")
    end
  
    if(step == 4)
        disp("-------------------------------------------------------");
        disp(" ")
        disp("                     Image Analysis                  ");
        disp(" ")
        disp("-------------------------------------------------------");
        disp(" ");
        disp("Computation of the angles and stifness : Done")
        disp(" ")
        disp("Saving the data                        : Done")
        disp(" ")
    end











