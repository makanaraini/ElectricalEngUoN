% Specifications
fs = 30000; % Sampling frequency (30 kHz)
fp = 5000;  % Pass-band frequency (5 kHz)
fs_stop = 15000; % Stop-band frequency (15 kHz)
Ap = 3;     % Pass-band ripple (3 dB)
As = 40;    % Stop-band attenuation (40 dB)

% Normalized frequencies
Wn = fp / (fs / 2); % Normalized pass-band frequency
Ws = fs_stop / (fs / 2); % Normalized stop-band frequency

% Estimate the least order of the filter using Remez algorithm
[n, fo, mo, w] = remezord([fp, fs_stop], [1, 0], [10^(Ap/20)-1, 10^(-As/20)], fs);
disp(['Estimated least order of the filter: ', num2str(n)]);

% Design the filter using the Remez algorithm
b = remez(n, [0, fp, fs_stop, fs/2] / (fs/2), [1, 0]); % Filter coefficients

% Calculate the impulse response
impulse_length = 50; % Length of impulse response
impulse = [1; zeros(impulse_length-1, 1)]; % Create an impulse signal
h = impz(b, 1, impulse_length); % Impulse response

% Plot the impulse response
figure;
stem(0:impulse_length-1, h, 'filled');
title('Impulse Response of the Low-Pass Filter');
xlabel('Samples');
ylabel('Amplitude');
grid on;

