%--------------------------------------------------------------------------
%                             Image terminal
%--------------------------------------------------------------------------
% @ Victor Mangeleer
% @ Arnaud Rémi
%
function balance_terminal(step, port, s_rate, duration)
    %--------------
    % Documentation
    %--------------
    % Display information about the image processing

    clc;
   
    % Running the script
    disp("-------------------------------------------------------");
    disp(" ")
    disp("                   Balance measurements                ");
    disp(" ")
    disp("-------------------------------------------------------");
    disp(" ");
    disp("Listening on port : " + port);
    disp(" ");
    disp("Saving rate [s]   : " + num2str(s_rate));
    disp(" ");
    disp("Duration [s]      : " + num2str(duration));
    disp(" ");
    disp("------");
    disp("Status");
    disp("------");

    if step > 1
        disp("Measuring       : Terminated");
    else
        disp("Measuring       : Activated");
    end

    disp(" ");

    if step > 1
        disp("Saving results  : Done")
    else
        disp("Saving results  : ...")
    end    

    disp(" ");
end






