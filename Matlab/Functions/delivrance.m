%--------------------------------------------------------------------------
%                           Loading the results
%--------------------------------------------------------------------------
RESULTS = {dir("Results/").name};
RESULTS = RESULTS(~strncmp(RESULTS, '.', 1));
NB_RESULTS = length(RESULTS);


% Parameters
W = 0.012;

L = 0.049;

S = W * L;

m_0 = 0.28;

g = 9.81;

Petiole_length = 0.0065;

rho = 1000;

L_tilde = (L/2) + Petiole_length;

alpha_crit_rad = 48.6 * 2 * pi / 360;

for i = 0 : NB_RESULTS - 1

    % Name of the experiment
    exp_name = "Results/Experiment_" + string(i) + ".txt";
    exp = table2array(readtable(exp_name));

    alpha_0       = exp(1) - 2;
    alpha_0_error   = exp(2);
    m_crit = exp(4);
    mu_exp        = exp(6);

    % Stiffness
    k_0  = get_stiffness(alpha_0 * 2 * pi / 360, m_0, L_tilde, 9.81);

    % New mu_theoretical
    mu_th  = 1000 * capacity(L, Petiole_length, W * L, k_0, alpha_0 * 2 * pi / 360, alpha_crit_rad);

    r1 = k_0/((m_0 * 0.001) * L_tilde * g);
    r2_theorical    = (rho * g * (mu_th  * 0.001)  * S * L_tilde)/((m_0 * 0.001) * L_tilde * g);
    r2_experimental = (rho * g * (mu_exp * 0.001) * S * L_tilde)/((m_0 * 0.001) * L_tilde * g);
    ratio = (r2_theorical - r2_experimental)/r2_theorical;

    T = table(alpha_0, alpha_0_error, k_0, m_crit, mu_th, mu_exp, r1, r2_theorical, r2_experimental,  ...
         'VariableNames', {'alpha_0', 'alpha_0 (ERROR)', 'k_0', 'm_crit', 'mu_th', 'mu_exp', 'r1', 'r2_th', 'r2_exp'});

    RESULT_NAME = "Experiment_" + string(i) + ".txt";
    writetable(T, "Results/corrected/" + RESULT_NAME);
end