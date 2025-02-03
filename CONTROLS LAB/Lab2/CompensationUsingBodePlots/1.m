% Step 1: Determine K
K = 12;

% Step 2: Plot Bode plot of uncompensated system
s = tf('s');
G1 = K / (s * (s + 1)); % Uncompensated system
figure;
bode(G1);
grid on;
title('Bode Plot of Uncompensated System');

% Step 3: Determine required phase lead
[~, phase_margin_uncomp, ~, ~] = margin(G1);
phi_m = 45 - phase_margin_uncomp + 10; % Add safety margin
a = (1 + sind(phi_m)) / (1 - sind(phi_m)); % Lead ratio

% Step 4: Design lead compensator
omega_m = 3; % Choose new gain crossover frequency (adjust based on Bode plot)
T = 1 / (omega_m * sqrt(a)); % Time constant
D = (1 + a*T*s) / (1 + T*s); % Lead compensator

% Step 5: Plot Bode plot of compensated system
G_compensated = G1 * D; % Compensated system
figure;
bode(G_compensated);
grid on;
title('Bode Plot of Compensated System');
margin(G_compensated); % Verify phase margin