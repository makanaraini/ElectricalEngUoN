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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Deepseek

% Clear workspace and command window
clear;
clc;

% Step 1: Define the open-loop transfer function (OLTF)
num = 1; % Numerator of GH(s)
den = conv([1 0], conv([1 2], [1 4])); % Denominator of GH(s) = s(s+2)(s+4)
GH = tf(num, den); % Open-loop transfer function

% Display the open-loop transfer function
disp('Open-Loop Transfer Function GH(s):');
disp(GH);

% Step 2: Define the desired damping ratio
zeta = 0.5; % Desired damping ratio

% Step 3: Plot the root locus
figure;
rlocus(GH); % Plot root locus
title('Root Locus of GH(s)');
grid on;

% Step 4: Find the gain K for the desired damping ratio
disp('Click on the root locus to select the desired pole location.');
[K, poles] = rlocfind(GH); % Interactive gain selection
fprintf('Selected Gain K = %.2f\n', K);

% Step 5: Display the closed-loop poles
disp('Closed-Loop Poles:');
disp(poles);

% Step 6: Check if multiple values of K satisfy the condition
% The root locus plot will show if multiple points correspond to zeta = 0.5
% If the root locus intersects the zeta = 0.5 line at multiple points,
% multiple values of K will satisfy the condition.

% Step 7: Verify the damping ratio of the selected poles
theta = acos(zeta); % Angle corresponding to zeta = 0.5
desired_angle = theta * 180/pi; % Convert to degrees

% Calculate the angle of the selected poles
pole_angles = angle(poles) * 180/pi; % Convert to degrees
fprintf('Angle of Selected Poles: %.2f degrees\n', pole_angles(1));

% Check if the selected poles have the desired damping ratio
if abs(pole_angles(1) - desired_angle) < 1e-2
    disp('The selected poles have the desired damping ratio (zeta = 0.5).');
else
    disp('The selected poles do not have the desired damping ratio.');
end

