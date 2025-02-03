% Step 1: Determine K
K = 1000; % Maximum value to satisfy K_a <= 25

% Step 2: Plot Bode plot of uncompensated system
s = tf('s');
G2 = K / (s * (s + 2) * (s + 20)); % Uncompensated system
figure;
bode(G2);
grid on;
title('Bode Plot of Uncompensated System');

% Step 3: Determine required phase margin and design lag compensator
[~, phase_margin_uncomp, ~, ~] = margin(G2);
desired_phase_margin = 35; % Desired phase margin
required_attenuation = % Calculate based on desired phase margin

% Step 4: Design lag compensator
b = 0.1; % Example value (adjust based on required attenuation)
omega_gc = % Choose new gain crossover frequency (adjust based on Bode plot)
T = 10 / (b * omega_gc); % Time constant
D = (1 + b*T*s) / (1 + T*s); % Lag compensator

% Step 5: Plot Bode plot of compensated system
G_compensated = G2 * D; % Compensated system
figure;
bode(G_compensated);
grid on;
title('Bode Plot of Compensated System');
margin(G_compensated); % Verify phase margin