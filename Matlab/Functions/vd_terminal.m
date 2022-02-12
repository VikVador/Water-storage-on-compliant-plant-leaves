%--------------------------------------------------------------------------
%                             Image terminal
%--------------------------------------------------------------------------
% @ Victor Mangeleer
% @ Arnaud Rémi
%
function vd_terminal(step)
    %--------------
    % Documentation
    %--------------
    % Display information about the image processing

    clc;
    disp("-------------------------------------------------------");
    disp(" ")
    disp("                     Video Processing                  ");
    disp(" ")
    disp("-------------------------------------------------------");
    disp(" ");

    if step == 1
        disp("Generation of the frames : ...");
        disp(" ");
    end

    if step == 2
        disp("Generation of the frames : Done");
        disp(" ");
    end
end