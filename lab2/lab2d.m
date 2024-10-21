% Specifications
fs = 30000; % Sampling frequency (30 kHz, must be greater than 15 kHz)
fp = 5000;  % Pass-band frequency (5 kHz)
fs_stop = 15000; % Stop-band frequency (15 kHz)
Ap = 3;     % Pass-band ripple (3 dB)
As = 40;    % Stop-band attenuation (40 dB)

% Calculate the order of the analogue Butterworth filter
n = ceil(log10((10^(As/10) - 1) / (10^(Ap/10) - 1)) / (2 * log10(fs_stop / fp)));
disp(['Order of the analogue Butterworth filter: ', num2str(n)]);

% Design the analogue Butterworth filter
[Z, P, K] = butter(n, fp/(fs/2), 'low', 's'); % 's' for analogue filter
[num, den] = zp2tf(Z, P, K); % Convert to transfer function

% Frequency response of the analogue filter
w = logspace(1, 5, 500); % Frequency range from 10 Hz to 100 kHz
H_analog = freqs(num, den, w); % Frequency response

% Design the digital Butterworth filter using bilinear transformation
[bd, ad] = butter(n, fp/(fs/2), 'low'); % 'low' for digital filter

% Frequency response of the digital filter
[H_digital, f] = freqz(bd, ad, 512, 'whole'); % Frequency response

% Plot the frequency responses
figure;

% Plot for the analogue filter
subplot(2, 1, 1);
semilogx(w, 20*log10(abs(H_analog))); % Convert to dB
title('Frequency Response of Analogue Butterworth Filter');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
grid on;
axis([10 100000 -60 5]); % Set axis limits
hold on;
yline(-3, 'r--', '3 dB Point'); % Mark the 3 dB point
yline(-43, 'g--', '40 dB Attenuation'); % Mark the 40 dB attenuation point
hold off;

% Plot for the digital filter
subplot(2, 1, 2);
semilogx(f * fs / (2 * pi), 20*log10(abs(H_digital))); % Convert to dB
title('Frequency Response of Digital Butterworth Filter');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
grid on;
axis([10 100000 -60 5]); % Set axis limits
hold on;
yline(-3, 'r--', '3 dB Point'); % Mark the 3 dB point
yline(-43, 'g--', '40 dB Attenuation'); % Mark the 40 dB attenuation point
hold off;

