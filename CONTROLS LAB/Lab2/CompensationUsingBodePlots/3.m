% MATLAB Code
% Step 1: Determine K
K = 2000;

% Step 2: Plot Bode plot of uncompensated system
s = tf('s');
G3 = K / (s * (s + 4) * (s + 20)); % Uncompensated system
figure;
bode(G3);
grid on;
title('Bode Plot of Uncompensated System');

% Step 3: Design lag-lead compensator
% Extract phase margin and gain crossover frequency
[~, phase_margin_uncomp, ~, omega_gc_uncomp] = margin(G3);

% Desired phase margin
desired_phase_margin = 35;

% Calculate required phase lead
phi_m = desired_phase_margin - phase_margin_uncomp + 10; % Add safety margin

% Lead compensator design
a = (1 + sind(phi_m)) / (1 - sind(phi_m)); % Lead ratio
T1 = 1 / (omega_gc_uncomp * sqrt(a)); % Time constant for lead
D_lead = (1 + a*T1*s) / (1 + T1*s); % Lead compensator

% Lag compensator design
b = 0.1; % Lag ratio
T2 = 10 / (b * omega_gc_uncomp); % Time constant for lag
D_lag = (1 + b*T2*s) / (1 + T2*s); % Lag compensator

% Combine lead and lag compensators
D = D_lead * D_lag; % Lag-lead compensator

% Step 4: Plot Bode plot of compensated system
G_compensated = G3 * D; % Compensated system
figure;
bode(G_compensated);
grid on;
title('Bode Plot of Compensated System');
margin(G_compensated); % Verify phase margin