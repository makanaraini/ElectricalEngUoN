% MATLAB Code for Compensation Using Root Locus

% Step 1: Define the uncompensated system
num = 1; % Numerator of G1(s)
den = [1, 5, 4, 0]; % Denominator of G1(s): s(s+1)(s+4) = s^3 + 5s^2 + 4s
sys = tf(num, den); % Uncompensated system G1(s)

% Step 2: Plot the root locus of the uncompensated system
figure;
rlocus(sys);
title('Root Locus of Uncompensated System');
grid on;

% Step 3: Define the desired pole locations
delta = 0.5; % Damping ratio
wn = 2; % Undamped natural frequency
desired_poles = roots([1, 2*delta*wn, wn^2]); % Desired poles: s^2 + 2s + 4 = 0
disp('Desired Pole Locations:');
disp(desired_poles);

% Step 4: Design the compensator (phase-lag compensator)
z = 0.1; % Zero of the compensator
p = 0.01; % Pole of the compensator
num_comp = [1, z]; % Numerator of compensator: s + z
den_comp = [1, p]; % Denominator of compensator: s + p
comp = tf(num_comp, den_comp); % Compensator transfer function Gc(s)

% Step 5: Combine the compensator with the original system
sys_comp = comp * sys; % Compensated system Gc(s) * G1(s)

% Step 6: Plot the root locus of the compensated system
figure;
rlocus(sys_comp);
title('Root Locus of Compensated System');
grid on;

% Step 7: Determine the gain K using rlocfind
disp('Select the desired pole location on the root locus plot.');
[K, poles] = rlocfind(sys_comp); % Select the desired pole location
disp('Gain K:');
disp(K);
disp('Closed-loop poles:');
disp(poles);

% Step 8: Verify the step response of the compensated system
sys_cl = feedback(K * sys_comp, 1); % Closed-loop system
figure;
step(sys_cl);
title('Step Response of Compensated System');
grid on;

% Step 9: Display system characteristics
stepinfo(sys_cl) % Display step response characteristics