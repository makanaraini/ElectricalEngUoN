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

