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
%-----------
% Parameters
%-----------
% Number of time the same experiment is done
exp_periodicity = 5;

%--------------------
% Loading the results
%--------------------
% Loading the results
RESULTS = {dir("Results/").name};
RESULTS = RESULTS(~strncmp(RESULTS, '.', 1));
NB_RESULTS = length(RESULTS);

% Index to fill the matrices
index_lines = 1;
index_col   = 1;

for i = 0 : NB_RESULTS - 1

    % Name of the experiment
    exp_name = "Results/Experiment_" + string(i) + ".txt";
    exp = table2array(readtable(exp_name));

    % Filling the matrix
    alpha(index_lines, index_col)       = exp(1);
    alpha_error(index_lines, index_col) = exp(2);
    k0(index_lines, index_col)          = exp(3);
    mu_th(index_lines, index_col)       = exp(5);
    mu_exp(index_lines, index_col)      = exp(6);

    % Updating indexes
    index_col = index_col + 1;

    if index_col > exp_periodicity
        index_col   = 1;
        index_lines = index_lines + 1;
    end
end

%---------------
%
%---------------

alpha_mean = mean(alpha, 2);
alpha_mean(end) = [];

alpha_std = std(alpha, 0, 2);

k_mean = mean(k0, 2);
k_mean(end) = [];

mu_exp_mean = mean(mu_exp, 2);
mu_exp_mean(end) = [];

mu_over_k_std = std(mu_exp./k0, 0, 2);

L2_Title();
%---------------------
% Plotting the results
%---------------------
clf;
figure;

% Theoretical
alpha_crit_mean = 48.6; % deg
a0 = 0.1:0.001:alpha_crit_mean*2*pi/360;
plot(a0, alpha_crit_mean*(2*pi/360)/cos(alpha_crit_mean*(2*pi/360)) * ones(1,length(a0)) - a0./cos(a0), '--k', 'linewidth', 2)

L = 0.049;
W = 0.012;
S = L*W;
l_tild = L/2;
rho = 1000;
g = 9.81;


pi_mu = mu_exp_mean * S * rho * g * l_tild ./ k_mean * 0.001; %mm
pi_mu_std = mu_over_k_std *  S * rho * g * l_tild * 0.001;

hold on;
plot(alpha_mean*2*pi/360, pi_mu, 'o');


FIG_volume = figure(1);
set(FIG_volume, 'defaulttextinterpreter','latex');
plot(a0, alpha_crit_mean*(2*pi/360)/cos(alpha_crit_mean*(2*pi/360)) * ones(1,length(a0)) - a0./cos(a0), '--k', 'linewidth', 2)
hold on;
errorbar(alpha_mean*2*pi/360, pi_mu, alpha_std, alpha_std, pi_mu_std, pi_mu_std, 'o', ...
         'color', [1, 0, 0], 'markersize', 6, 'LineWidth', 1);
xlabel('$V_{mean}$ [$\mu L$]');
ylabel('$\alpha_{critical}$ [$^{\circ}$]');
set(gca, 'fontsize', 24, 'fontname', 'Times', 'LineWidth', 0.5);
grid on;




