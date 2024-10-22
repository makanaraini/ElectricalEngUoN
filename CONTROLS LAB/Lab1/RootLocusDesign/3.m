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

