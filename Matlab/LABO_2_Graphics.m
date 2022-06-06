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

%--------------------------------------------------------------------------
%                           Loading the results
%--------------------------------------------------------------------------
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
    r1(index_lines, index_col)              = exp(7);
    r2_experimental(index_lines, index_col) = exp(9);

    % Updating indexes
    index_col = index_col + 1;

    if index_col > exp_periodicity
        index_col   = 1;
        index_lines = index_lines + 1;
    end
end

%---------------------------
%    Plotting the results
%---------------------------
% Theoretical curve
th_domain  = 0.5 : 0.01 : 2;
angle_crit = 48.6 * 2 * pi /360;
const      = angle_crit/(cos(angle_crit));

figure(1);

pigment_color = [166,93,116]/255;

% Experimental curve
r1_mean = mean(r1, 2);
r2_ex_mean = mean(r2_experimental, 2)
r1_std = std(r1, 0, 2);
r2_ex_std = std(r2_experimental, 0, 2);
errorbar(r1_mean, r2_ex_mean, r2_ex_std, r2_ex_std, r1_std, r1_std, 'o', ...
          'color', pigment_color, 'markersize', 3, 'LineWidth', 1);
hold on;

plot(th_domain, const * th_domain - 1, '--k', 'linewidth', 1.5);
legend({'Experimental', 'Model'}, 'interpreter', 'latex', 'fontsize', 16)

      
% Theoretical curve with alpha error
alpha_error = 4.004;
angle_crit_w_error = (48.6 - alpha_error) * 2 * pi /360;
const      = angle_crit_w_error/(cos(angle_crit_w_error));
plot(th_domain, const * th_domain - 1, '--k', 'linewidth', 1);
hold on;

angle_crit_w_error = (48.6 + alpha_error) * 2 * pi /360;
const      = angle_crit_w_error/(cos(angle_crit_w_error));
plot(th_domain, const * th_domain - 1, '--k', 'linewidth', 1);
xlim([0.7 1.75]);
ylim([0 1.5]);



set(gca, 'fontsize', 16, 'fontname', 'Times', 'LineWidth', 0.5);
xlabel('$\frac{k}{mlg}$ [-]', 'fontsize', 21, 'interpreter', 'latex')
ylabel('$\frac{\mu_{\star} S \rho g \tilde{l}}{mlg}$ [-]', 'fontsize', 21, 'interpreter', 'latex')
%grid minor
