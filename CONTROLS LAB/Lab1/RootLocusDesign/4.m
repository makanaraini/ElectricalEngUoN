% Define the plant
s = tf('s');
G1 = 1 / ((s + 1) * (s + 3));

% Define the proportional gain K
Kp = 4; % Initial gain
K = Kp; % Start with K equal to Kp

% Create the open-loop transfer function
L = K * G1;

% Generate the root locus plot
figure;
rlocus(L);
title('Root Locus of the System');
grid on;

% Analyze the closed-loop poles for different values of K
K_values = 0:0.1:10; % Range of K values
poles = zeros(length(K_values), 2); % Preallocate for poles

for i = 1:length(K_values)
    K = K_values(i);
    T = feedback(K * G1, 1); % Closed-loop transfer function
    poles(i, :) = pole(T); % Store the poles
end

% Plot the poles on the root locus
hold on;
plot(real(poles), imag(poles), 'x');
hold off;

% Check specifications
for i = 1:length(K_values)
    K = K_values(i);
    T = feedback(K * G1, 1);
    step_info = stepinfo(T);
    
    % Display if specifications are met
    if step_info.Overshoot <= 20 && step_info.RiseTime <= 1
        disp(['K = ', num2str(K), ' meets specifications: Overshoot = ', num2str(step_info.Overshoot), ', Rise Time = ', num2str(step_info.RiseTime)]);
    end
end

