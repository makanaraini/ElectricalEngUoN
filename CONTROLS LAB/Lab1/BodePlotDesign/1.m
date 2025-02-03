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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Deepseek
% Clear workspace and command window
clear;
clc;

% Step 1: Define the open-loop transfer function (OLTF)
s = tf('s');
GH = 2 / ((1 + s) * (1 + s/10 - (s/4)^2)); % OLTF

% Step 2: Plot the Bode plot of the uncompensated system
figure;
margin(GH); % Bode plot with gain and phase margins
title('Bode Plot of Uncompensated System');
grid on;

% Step 3: Analyze the gain and phase margins of the uncompensated system
[Gm_uncomp, Pm_uncomp, Wcg_uncomp, Wcp_uncomp] = margin(GH);
fprintf('Uncompensated System:\n');
fprintf('Gain Margin = %.2f dB\n', 20*log10(Gm_uncomp));
fprintf('Phase Margin = %.2f°\n', Pm_uncomp);

% Step 4: Design a compensator to meet the specifications
% Desired specifications:
% Gain Margin >= 6 dB
% Phase Margin >= 40°

% Check if compensation is needed
if (20*log10(Gm_uncomp) < 6 || Pm_uncomp < 40)
    % Design a lead compensator to improve phase margin
    % Lead compensator form: Gc(s) = Kc * (1 + T*s) / (1 + alpha*T*s)
    % Choose alpha and T to provide sufficient phase boost.

    % Example: Choose alpha = 0.1 and T = 0.1
    alpha = 0.1;
    T = 0.1;
    Gc = (1 + T*s) / (1 + alpha*T*s); % Lead compensator

    % Step 5: Add the compensator to the system
    GH_comp = Gc * GH; % Compensated OLTF

    % Step 6: Plot the Bode plot of the compensated system
    figure;
    margin(GH_comp); % Bode plot with gain and phase margins
    title('Bode Plot of Compensated System');
    grid on;

    % Step 7: Analyze the gain and phase margins of the compensated system
    [Gm_comp, Pm_comp, Wcg_comp, Wcp_comp] = margin(GH_comp);
    fprintf('Compensated System:\n');
    fprintf('Gain Margin = %.2f dB\n', 20*log10(Gm_comp));
    fprintf('Phase Margin = %.2f°\n', Pm_comp);
else
    fprintf('No compensation needed. Specifications are already met.\n');
end