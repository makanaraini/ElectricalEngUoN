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

% Calculate the poles and zeros
[Z, P, K] = tf2zp(b, 1); % Zeros, poles, and gain

% Display poles and zeros
disp('Poles and Zeros:');
disp('Zeros:');
disp(Z);
disp('Poles:');
disp(P);

% Plot poles and zeros
figure;
zplane(Z, P);
title('Poles and Zeros of the Low-Pass Filter');
grid on;

