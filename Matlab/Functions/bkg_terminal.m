%--------------------------------------------------------------------------
%                          Background terminal
%--------------------------------------------------------------------------
% @ Victor Mangeleer
% @ Arnaud Rémi
%
function bkg_terminal(step)
    %--------------
    % Documentation
    %--------------
    % Display information about the image processing

    clc;
    disp("-------------------------------------------------------");
    disp(" ")
    disp("                  Background Processing                  ");
    disp(" ")
    disp("-------------------------------------------------------");
    disp(" ");

    if step == 1
        disp("Generation of the background : ...");
        disp(" ");
    end

    if step == 2
        disp("Generation of the background : Done");
        disp(" ");
    end
end