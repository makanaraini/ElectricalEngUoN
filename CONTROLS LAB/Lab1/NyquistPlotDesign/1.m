% Define the system transfer function
s = tf('s');
GH = 84 / (s * (s + 2) * (s + 6));

% Plot the Nyquist plot
figure;
nyquist(GH);
grid on;
title('Nyquist Plot of the Open-Loop System');

% Design a compensator (example: lead compensator)
% Adjust the parameters as necessary
K = 1; % Gain
alpha = 10; % Adjust this value for desired phase margin
C = K * (s + alpha) / (s + 1); % Lead compensator

% Open-loop transfer function with compensator
G_open_loop = C * GH;

% Verify the phase margin
figure;
margin(G_open_loop);
grid on;
title('Bode Plot with Phase Margin');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Deepseek

% Clear workspace and command window
clear;
clc;

% Step 1: Define the open-loop transfer function (OLTF)
s = tf('s');
GH = 84 / (s * (s + 2) * (s + 6)); % OLTF

% Step 2: Plot the Nyquist plot of the uncompensated system
figure;
nyquist(GH);
title('Nyquist Plot of Uncompensated System');
grid on;

% Step 3: Analyze the phase margin of the uncompensated system
[Gm_uncomp, Pm_uncomp, Wcg_uncomp, Wcp_uncomp] = margin(GH);
fprintf('Uncompensated System:\n');
fprintf('Phase Margin = %.2f°\n', Pm_uncomp);

% Step 4: Design a compensator if needed
if Pm_uncomp < 45
    % Desired phase margin = 45°
    phase_boost = 45 - Pm_uncomp;

    % Choose alpha and T for the lead compensator
    alpha = 0.1; % Typical value for lead compensators
    T = 0.1; % Time constant

    % Lead compensator transfer function
    Gc = (1 + T*s) / (1 + alpha*T*s);

    % Compensated open-loop transfer function
    GH_comp = Gc * GH;

    % Step 5: Plot the Nyquist plot of the compensated system
    figure;
    nyquist(GH_comp);
    title('Nyquist Plot of Compensated System');
    grid on;

    % Step 6: Analyze the phase margin of the compensated system
    [Gm_comp, Pm_comp, Wcg_comp, Wcp_comp] = margin(GH_comp);
    fprintf('Compensated System:\n');
    fprintf('Phase Margin = %.2f°\n', Pm_comp);
else
    fprintf('No compensation needed. Phase margin is already ≥ 45°.\n');
end