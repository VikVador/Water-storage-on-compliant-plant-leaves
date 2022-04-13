function mu = capacity(l, S, k_0, alpha_0, alpha)
rho = 1000;
g = 9.81;
l_tild = l/2;

mu = k_0/(S*rho*g*l_tild) *( alpha/cos(alpha) - alpha_0/cos(alpha_0));
end