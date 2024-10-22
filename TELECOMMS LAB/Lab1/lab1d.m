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

% Frequency response of the analogue filter H0(s)
w = logspace(-1, 2, 500); % Frequency range for analogue filter
H0 = freqs(num, den, w); % Frequency response of H0(s)

% Frequency response of the digital filter H1(z)
[H1, f1] = freqz(bd1, ad1, 512, 'whole'); % Frequency response of H1(z)

% Frequency response of the digital filter H2(z)
[H2, f2] = freqz(bd2, ad2, 512, 'whole'); % Frequency response of H2(z)

% Plot the frequency responses
figure;

subplot(3, 1, 1);
semilogx(w, 20*log10(abs(H0))); % Convert to dB
title('Frequency Response of H0(s)');
xlabel('Frequency (rad/s)');
ylabel('Magnitude (dB)');
grid on;

subplot(3, 1, 2);
semilogx(f1, 20*log10(abs(H1))); % Convert to dB
title('Frequency Response of H1(z) (Impulse Invariance)');
xlabel('Frequency (rad/sample)');
ylabel('Magnitude (dB)');
grid on;

subplot(3, 1, 3);
semilogx(f2, 20*log10(abs(H2))); % Convert to dB
title('Frequency Response of H2(z) (Bilinear Transform)');
xlabel('Frequency (rad/sample)');
ylabel('Magnitude (dB)');
grid on;

% Compare the frequency responses after one period
% For digital filters, we can use the Nyquist frequency
nyquist_freq = fs / 2; % Nyquist frequency
f1_period = linspace(0, nyquist_freq, 512); % Frequency range for H1(z)
f2_period = linspace(0, nyquist_freq, 512); % Frequency range for H2(z)

% Plot the frequency responses for one period
figure;

subplot(2, 1, 1);
plot(f1_period, 20*log10(abs(H1(1:256)))); % First half for one period
hold on;
plot(f1_period, 20*log10(abs(H2(1:256))), '--'); % First half for one period
title('Frequency Response Comparison (One Period)');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
legend('H1(z)', 'H2(z)');
grid on;

subplot(2, 1, 2);
plot(f1_period, 20*log10(abs(H0(1:256)))); % First half for one period
title('Frequency Response of H0(s) (One Period)');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
grid on;

