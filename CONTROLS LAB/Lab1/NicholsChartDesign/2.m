% Define the parameters
s = tf('s');
K = 1; % Use the value of K found previously
desired_Mp = 1.4; % Desired resonant peak in dB

% Define the open-loop transfer function
G = K / (s * (1 + 200) * (1 + s/250));

% Generate Bode plot
figure;
bode(G);
grid on;

% Get the gain and phase data
[mag, phase, w] = bode(G);

% Convert magnitude to dB
mag_dB = 20*log10(squeeze(mag));

% Find the maximum gain and corresponding frequency
[max_gain, idx] = max(mag_dB);
frequency_at_max_gain = w(idx);

% Display results
fprintf('Maximum Gain = %.2f dB at Frequency = %.2f rad/s\n', max_gain, frequency_at_max_gain);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Deepseek

% Clear workspace and command window
clear;
clc;

% Step 1: Define the open-loop transfer function (OLTF)
s = tf('s');
K = 1.2345; % Value of K from Question 1
GH = K / (s * (1 + s/200) * (1 + s/250)); % OLTF with K

% Step 2: Plot the Bode plot of the system
figure;
margin(GH); % Bode plot with gain and phase margins
title('Bode Plot of GH(s)');
grid on;

% Step 3: Analyze the resonant peak
[mag, phase, w] = bode(GH);
mag_db = 20 * log10(squeeze(mag)); % Convert magnitude to dB

% Find the resonant peak (maximum magnitude in dB)
Mp = max(mag_db);
fprintf('Resonant Peak (Mp) = %.2f dB\n', Mp);