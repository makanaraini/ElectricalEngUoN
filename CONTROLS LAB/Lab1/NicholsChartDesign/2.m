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

