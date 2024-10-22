% Define the analogue filter transfer function H0(s)
num = [2]; % Numerator coefficients
den = [1 3 1]; % Denominator coefficients (s^2 + 3s + 2)

% Calculate the poles and zeros of the analogue filter
[z, p, k] = tf2zp(num, den); % Zeros, poles, and gain
disp('Zeros of H0(s):');
disp(z);
disp('Poles of H0(s):');
disp(p);

% Convert to IIR digital filter using impulse invariance
fs = 10; % Sampling frequency
[bd1, ad1] = impinvar(num, den, fs); % Digital filter coefficients for H1(z)

% Convert to IIR digital filter using bilinear transform
[bd2, ad2] = bilinear(num, den, fs); % Digital filter coefficients for H2(z)

% Calculate the impulse responses
[impulse_response_H1, t1] = impz(bd1, ad1, 50); % Impulse response for H1(z)
[impulse_response_H2, t2] = impz(bd2, ad2, 50); % Impulse response for H2(z)

% Plot the impulse responses
figure;

subplot(3, 1, 1);
stem(t1, impulse_response_H1, 'filled');
title('Impulse Response of H1(z) (Impulse Invariance)');
xlabel('Samples');
ylabel('Amplitude');
grid on;

subplot(3, 1, 2);
stem(t2, impulse_response_H2, 'filled');
title('Impulse Response of H2(z) (Bilinear Transform)');
xlabel('Samples');
ylabel('Amplitude');
grid on;

% Calculate the impulse response of the analogue filter H0(s)
impulse_length = 50; % Length of impulse response
t = 0:1/fs:(impulse_length-1)/fs; % Time vector
sys = tf(num, den); % Create transfer function object
impulse_response_H0 = impulse(sys, t); % Impulse response for H0(s)

subplot(3, 1, 3);
stem(t, impulse_response_H0, 'filled');
title('Impulse Response of H0(s)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% Compare the responses
disp('Comparison of Impulse Responses:');
disp('H1(z) Impulse Response:');
disp(impulse_response_H1);
disp('H2(z) Impulse Response:');
disp(impulse_response_H2);
disp('H0(s) Impulse Response:');
disp(impulse_response_H0);
