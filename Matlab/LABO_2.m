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
addpath('Functions/');
cleaning;

%--------------------------------------------------------------------------
%                   Dimensions and experiment parameters
%--------------------------------------------------------------------------
% Dry mass of the leaf [g]
m_0 = 0.376;

% Length of the leaf [m]
L = 0.064;

% Length of the petiole [m]
Petiole_length = 0.002;

% Width of the leaf [m]
W = 0.0125;

% Critical angle of the droplet
alpha = 48.6;

% Gravity constant
g = 9.81;

% Volumic mass
rho = 1000;

% Surface
S = L * W;

L_tilde = (L/2) + Petiole_length;

%--------------------------------------------------------------------------
%                           Laboratory interactions
%--------------------------------------------------------------------------
% 1 - Processing the initial images
L2_Title();
disp("Note : The folders are going to be cleaned, ");
disp("       do you want to continue ?");
L2_interaction();
disp("BEFORE YOU START");
disp(" ");
disp("    Are you sure that the processing parameters are well set-up ?");
L2_interaction();
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

% Determining the dry angle and the intial stiffness
[alpha_0, alpha_0_error, k_0] = Image_Analysis(m_0, L, Petiole_length);

% Conversion of angles
alpha_0_rad = alpha_0;
alpha_0 = alpha_0 * (360/(2 * pi));
alpha_rad = alpha * 2 * pi / 360;


% 2 - Initial results of the experiment
L2_Title();
disp("INITIAL RESULTS");
disp(" ");
disp("alpha_0         = " + string(alpha_0));
disp(" ");
disp("k_0             = " + string(k_0));
disp(" ");
disp("---------")
disp(" ");
disp("k_0/(m * l * g) = " + string(k_0/((m_0 * 0.001) * L_tilde * g)));
disp(" ");

% 3 - Making measurement with the balance
L2_interaction();
disp("BALANCE MEASUREMENT")
disp(" ");
interface;
disp(" ");
m_crit = input("Critical Mass =");

% Retreives critical mass value
%m_crit = table2array(readtable("MASS.txt"));

% Computes capacity
mu_th  = 1000 * capacity(L, Petiole_length, W * L, k_0, alpha_0_rad, alpha_rad);
mu_exp = 0.001 * m_crit/(W * L); % [mm]

%---------------------
% END OF MANIPULATIONS
%---------------------
% Computing final ratios
r1 = k_0/((m_0 * 0.001) * L_tilde * g);
r2_theorical    = (rho * g * mu_th  * S * L_tilde)/(m_0 * (L_tilde) * g);
r2_experimental = (rho * g * mu_exp * S * L_tilde)/(m_0 * (L_tilde) * g);

L2_Title();
disp("RESULTS OF THE EXPERIMENT");
disp(" ");
disp("alpha_0         = " + string(alpha_0));
disp(" ");
disp("alpha_0 (ERROR) = " + string(alpha_0_error));
disp(" ");
disp("k_0             = " + string(k_0));
disp(" ");
disp("m_crit          = " + string(m_crit));
disp(" ");
disp("mu_th           = " + string(mu_th));
disp(" ");
disp("mu_exp          = " + string(mu_exp));
disp(" ");
disp("-------------------");
disp("       RATIO       ");
disp("-------------------");
disp(" ");
disp("k_0/(m * l * g)      = " + string(r1));
disp(" ");
disp("Capa. Adim. Theo.    = " + string(r2_theorical));
disp(" ");
disp("Capa. Adim. Expe.    = " + string(r2_experimental));
disp(" ")
disp("Error on Adim. Capa. = " + string((r2_theorical - r2_experimental)/r2_theorical * 100) + " [%]");
disp(" ")

% Creation of table
T = table(alpha_0, alpha_0_error, k_0, m_crit, mu_th, mu_exp, r1, r2_theorical, r2_experimental,  ...
         'VariableNames', {'alpha_0', 'alpha_0 (ERROR)', 'k_0', 'm_crit', 'mu_th', 'mu_exp', 'r1', 'r2_th', 'r2_exp'});

% Creation of file name
RESULTS  = {dir("Results/").name};
RESULTS_length = length(RESULTS(~strncmp(RESULTS, '.', 1)));
RESULT_NAME = "Experiment_" + string(RESULTS_length) + ".txt";
writetable(T, "Results/" + RESULT_NAME);
disp(" ");
disp("Results are saved in : " + RESULT_NAME);
delete MASS.txt;
