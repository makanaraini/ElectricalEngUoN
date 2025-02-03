% Define parameters
zeta = 0.5; % Damping ratio
wn = 2; % Natural frequency

% Calculate the desired pole locations
p1 = -zeta * wn + 1i * wn * sqrt(1 - zeta^2);
p2 = -zeta * wn - 1i * wn * sqrt(1 - zeta^2);

% Display the poles
disp('Desired poles:');
disp(p1);
disp(p2);

% Calculate percentage overshoot
PO = 100 * exp(-zeta * pi / sqrt(1 - zeta^2));
disp(['Percentage Overshoot: ', num2str(PO), '%']);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Deepseek

% Clear workspace and command window
clear;
clc;

% Step 1: Define the open-loop transfer function (OLTF)
syms s K a;
num = K*(s + a); % Numerator of GH(s)
den = (s^2 - 1)*(s + 5); % Denominator of GH(s)
GH = num / den; % Open-loop transfer function

% Display the open-loop transfer function
disp('Open-Loop Transfer Function GH(s):');
disp(GH);

% Step 2: Define the desired damping ratio and natural frequency
zeta = 0.5; % Damping ratio
wn = 2; % Natural frequency

% Step 3: Calculate the desired pole locations
desired_poles = [-zeta*wn + 1i*wn*sqrt(1 - zeta^2), ...
                 -zeta*wn - 1i*wn*sqrt(1 - zeta^2), -3]; % Third pole at s = -3

% Step 4: Define the desired characteristic equation
desired_char_eq = (s - desired_poles(1)) * (s - desired_poles(2)) * (s - desired_poles(3));

% Step 5: Expand the desired characteristic equation
desired_char_eq_expanded = expand(desired_char_eq);

% Step 6: Expand the actual characteristic equation
actual_char_eq = den + num; % 1 + GH(s) = 0
actual_char_eq_expanded = expand(actual_char_eq);

% Step 7: Equate coefficients of the desired and actual characteristic equations
coeffs_desired = coeffs(desired_char_eq_expanded, s, 'All');
coeffs_actual = coeffs(actual_char_eq_expanded, s, 'All');

% Solve for K and a
eq1 = coeffs_actual(2) == coeffs_desired(2); % s^2 term
eq2 = coeffs_actual(3) == coeffs_desired(3); % s term
eq3 = coeffs_actual(4) == coeffs_desired(4); % constant term

sol = solve([eq1, eq2, eq3], [K, a]);

% Display the solutions
K_value = double(sol.K);
a_value = double(sol.a);
fprintf('K = %.4f\n', K_value);
fprintf('a = %.4f\n', a_value);

% Step 8: Calculate the percentage overshoot
OS = 100 * exp((-zeta * pi) / sqrt(1 - zeta^2));
fprintf('Percentage Overshoot = %.2f%%\n', OS);