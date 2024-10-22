% Define the open-loop transfer function G(s)
s = tf('s');
G = 2 / ((1 + 1j*s)*(1 + s/10 - (s/4)^2));

% Generate Bode plot for the open-loop system
figure;
bode(G);
grid on;
title('Bode Plot of Open-Loop System');

% Analyze the Bode plot to determine gain and phase margins
[GM, PM, Wcg, Wcp] = margin(G);
disp(['Gain Margin: ', num2str(GM), ' dB']);
disp(['Phase Margin: ', num2str(PM), ' degrees']);

% Design a compensator (example: PID controller)
Kp = 1; % Proportional gain
Ki = 1; % Integral gain
Kd = 1; % Derivative gain
C = pid(Kp, Ki, Kd);

% Closed-loop transfer function
T = feedback(C*G, 1);

% Generate Bode plot for the closed-loop system
figure;
bode(T);
grid on;
title('Bode Plot of Closed-Loop System');

