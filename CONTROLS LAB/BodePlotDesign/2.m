% Define the open-loop transfer function G(s)
s = tf('s');
G = 2 / ((1 + 1j*s)*(1 + s/10 - (s/4)^2));

% Generate Bode plot for the open-loop system
figure;
bode(G);
grid on;
title('Bode Plot of Open-Loop System');

% Analyze the Bode plot to determine gain and phase margins
[GM_open, PM_open, Wcg_open, Wcp_open] = margin(G);
disp(['Open-Loop Gain Margin: ', num2str(GM_open), ' dB']);
disp(['Open-Loop Phase Margin: ', num2str(PM_open), ' degrees']);

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

% Analyze the Bode plot for the closed-loop system
[GM_closed, PM_closed, Wcg_closed, Wcp_closed] = margin(T);
disp(['Closed-Loop Gain Margin: ', num2str(GM_closed), ' dB']);
disp(['Closed-Loop Phase Margin: ', num2str(PM_closed), ' degrees']);

% Check specifications
if GM_closed > 6
    disp('Gain Margin specification met.');
else
    disp('Gain Margin specification NOT met.');
end

if PM_closed > 30
    disp('Phase Margin specification met.');
else
    disp('Phase Margin specification NOT met.');
end

% Additional checks can be added here based on your specific requirements

