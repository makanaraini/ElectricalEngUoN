% Define the plant
s = tf('s');
G1 = 1 / ((s + 1) * (s + 3));

% Define the desired specifications
overshoot = 20; % percent
rise_time = 1; % seconds

% Calculate the required gain K using the specifications
Kp = 4; % Proportional gain
K = Kp; % Start with K equal to Kp

% Create the closed-loop transfer function
T = feedback(K * G1, 1);

% Check the step response for overshoot and rise time
step_info = stepinfo(T);

% Display the results
disp('Step Response Information:');
disp(step_info);

% Adjust K if necessary to meet the specifications
while step_info.Overshoot > overshoot || step_info.RiseTime > rise_time
    K = K + 0.1; % Increment K
    T = feedback(K * G1, 1);
    step_info = stepinfo(T);
end

% Final gain
disp(['Final Gain K: ', num2str(K)]);

