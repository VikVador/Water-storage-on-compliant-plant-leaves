%--------------------------------------------------------------------------
%
%                             Laboratory 2
%                         
%                         Alpha_0, k_0 et mu
%
%--------------------------------------------------------------------------
% @ Victor Mangeleer
% @ Arnaud Rémi
%
clc;
cleaning;
addpath('Functions/');
%--------------------------------------------------------------------------
%                           Documentation
%--------------------------------------------------------------------------
L2_Title();
disp("Note : The folders are going to be cleaned, ");
disp("       do you want to continue ?");
L2_interaction();

disp("BEFORE YOU START");
disp(" ");
disp("    Are you sure that the processing parameters are well set-up ?");
L2_interaction();

disp("LEAF PROPERTIES");
disp(" ");
disp("What is the dry mass ?")
disp(" ");
%m_0 = input("m_0 [g] = ");
disp(" ");
disp("What is the length ?")
disp(" ");
%L = input("L [m] = ");
disp(" ");
disp("What is the width ?")
disp(" ");
%W = input("w [m] = ");
disp(" ");
disp("What is the critical angle ?")
disp(" ");
%alpha = input("alpha [m] = ");

m_0 = 0.28;
L = 0.049;
W = 0.012;
alpha = 48.6;

L2_Title();
disp("IMAGE PROCESSING");
disp(" ");
disp("Take a picture of the backgound and place it in the");
disp("folder initial/Background with the name 'Background.jpg'");
L2_interaction();
disp("IMAGE PROCESSING");
disp(" ");
disp("Take a picture of the leaf initially and place it in the");
disp("folder initial/Photos with whatever name");
L2_interaction();

Image_Processing;
[alpha_0, alpha_0_error, k_0] = Image_Analysis(m_0, L);

% Conversion of angles
alpha_0_rad = alpha_0;
alpha_0 = alpha_0 * (360/(2 * pi));
alpha_rad = alpha * 2 * pi / 360;

L2_Title();
disp("COMPUTING THE RESULTS");
disp(" ");
disp("alpha_0         = " + string(alpha_0));
%disp(" ");
%disp("alpha_0 (ERROR) = " + string(alpha_0_error));
disp(" ");
disp("k_0             = " + string(k_0));
disp(" ");