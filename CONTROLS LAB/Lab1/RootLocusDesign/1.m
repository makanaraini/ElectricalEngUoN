% Define the plant
s = tf('s');
G1 = 1 / ((s + 1) * (s + 3));

% Design specifications
os_max = 20;                     % Maximum overshoot (%)
tr_max = 1;                      % Maximum rise time (s)
Kp_min = 4;                      % Minimum proportional gain

% Calculate required damping ratio from overshoot
zeta_min = -log(os_max/100) / sqrt(pi^2 + (log(os_max/100))^2);

% Plot root locus
figure(1)
rlocus(G1)
hold on
grid on
title('Root Locus with Design Specifications')

% Plot damping ratio lines
sgrid(zeta_min, [])
hold off

% Calculate a range of K values to test
K_range = linspace(Kp_min, 20, 100);  % Test K from Kp_min to 20
valid_K = [];

% Define time vector for step response
t = 0:0.01:10;

% Test each K value
figure(2)
hold on
grid on
title('Step Response for Valid K Values')
xlabel('Time (seconds)')
ylabel('Amplitude')

for K = K_range
    T = feedback(K * G1, 1);
    [y, t_out] = step(T, t);
    step_info = stepinfo(T);
    
    % Get poles of closed-loop system
    poles = pole(T);
    
    % Calculate damping ratio for dominant poles
    zeta = -real(poles(1)) / sqrt(real(poles(1))^2 + imag(poles(1))^2);
    
    % Check all specifications
    if zeta >= zeta_min && step_info.RiseTime <= tr_max
        valid_K = [valid_K; K];
        plot(t, y, 'LineWidth', 1.5)
    end
end

legend(cellstr(num2str(valid_K, 'K = %.1f')))
hold off

% Display results
if isempty(valid_K)
    disp('No K values satisfy all specifications')
else
    disp('K values satisfying all specifications:')
    disp(valid_K)
    
    % Use minimum K that satisfies specifications
    K_chosen = max(valid_K);
    T_final = feedback(K_chosen * G1, 1);
    
    % Display final system characteristics
    step_info_final = stepinfo(T_final);
    fprintf('\nChosen K: %.2f\n', K_chosen)
    fprintf('Overshoot: %.2f%%\n', step_info_final.Overshoot)
    fprintf('Rise Time: %.2f seconds\n', step_info_final.RiseTime)
    fprintf('Settling Time: %.2f seconds\n', step_info_final.SettlingTime)
    
    % Plot pole-zero map of final design
    figure(3)
    pzmap(T_final)
    grid on
    title('Pole-Zero Map of Final Design')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Deepseek
% Clear workspace and command window
clear;
clc;

% Step 1: Define the plant transfer function
num = 1; % Numerator of G1(s)
den = conv([1 1], [1 3]); % Denominator of G1(s) = (s+1)(s+3)
G1 = tf(num, den); % Plant transfer function

% Display the plant transfer function
disp('Plant Transfer Function G1(s):');
disp(G1);

% Step 2: Determine the desired specifications
zeta = 0.456; % Damping ratio for less than 20% overshoot
wn = 2.2; % Natural frequency for rise time less than 1 second

% Desired pole locations
desired_pole = -zeta*wn + 1i*wn*sqrt(1-zeta^2);

% Step 3: Plot the root locus
figure;
rlocus(G1); % Plot root locus
title('Root Locus of G1(s)');
grid on;

% Step 4: Find the gain K that places the poles at the desired location
disp('Click on the root locus to select the desired pole location.');
[K, poles] = rlocfind(G1, desired_pole); % Interactive gain selection
fprintf('Selected Gain K = %.2f\n', K);

% Step 5: Define the closed-loop system with the calculated gain K
G_cl = feedback(K*G1, 1); % Closed-loop transfer function

% Display the closed-loop transfer function
disp('Closed-Loop Transfer Function:');
disp(G_cl);

% Step 6: Plot the step response of the closed-loop system
figure;
step(G_cl); % Step response
title('Step Response of the Closed-Loop System');
grid on;

% Step 7: Calculate and display step response metrics
step_info = stepinfo(G_cl); % Get step response metrics
fprintf('Rise Time (10%% to 90%%) = %.4f seconds\n', step_info.RiseTime);
fprintf('Overshoot = %.2f%%\n', step_info.Overshoot);

% Step 8: Calculate and display the steady-state error constant Kp
Kp = dcgain(K*G1); % Steady-state error constant
fprintf('Steady-State Error Constant Kp = %.2f\n', Kp);

% Step 9: Verify if all specifications are met
if step_info.Overshoot < 20 && step_info.RiseTime < 1 && Kp >= 4
    disp('All specifications are met!');
else
    disp('Specifications are not met. Adjust the design.');
end