% Define the transfer function
num = [1]; % Numerator: s
den = conv([1 2], [1 4]); % Denominator: (s+2)(s+4)
sys = tf(num, den);

% Generate root locus
figure;
rlocus(sys);
title('Root Locus of the System');

% Desired pole location for damping ratio ζ = 0.5
zeta = 0.5;
wn = 1; % Natural frequency (you can adjust this)
desired_pole = -zeta * wn + 1i * wn * sqrt(1 - zeta^2);

% Calculate gain K for the desired pole
K = evalfr(sys, desired_pole);
disp(['Gain K for desired pole: ', num2str(K)]);

