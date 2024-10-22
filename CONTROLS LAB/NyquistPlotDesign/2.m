% Define the system transfer function
s = tf('s');
GH = 84 / (s * (s + 2) * (s + 6));

% Plot the Nyquist plot of the open-loop system
figure;
nyquist(GH);
hold on; % Keep the plot for overlaying the compensated system
grid on;
title('Nyquist Plot of the Open-Loop System');

% Design a compensator (example: lead compensator)
K = 1; % Gain
alpha = 10; % Adjust this value for desired phase margin
C = K * (s + alpha) / (s + 1); % Lead compensator

% Open-loop transfer function with compensator
G_open_loop = C * GH;

% Plot the Nyquist plot of the compensated system
nyquist(G_open_loop);
legend('Open-Loop System', 'Compensated System');
hold off;

% Analyze the Nyquist plot
% Check the phase margin
figure;
margin(G_open_loop);
grid on;
title('Bode Plot with Phase Margin');

