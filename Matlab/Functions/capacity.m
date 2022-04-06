function mu = capacity(S, k_0, alpha_0, alpha)
rho = 1;
g = 9.81;
l = 1/2;
mu = (k_0/(S*rho*g*l))*((alpha/cos(alpha)) - (alpha_0/cos(alpha_0)));
end