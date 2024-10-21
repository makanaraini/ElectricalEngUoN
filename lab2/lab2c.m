% Specifications
fp = 5000;  % Pass-band frequency (5 kHz)
fs_stop = 15000; % Stop-band frequency (15 kHz)
Ap = 3;     % Pass-band ripple (3 dB)
As = 40;    % Stop-band attenuation (40 dB)

% Calculate the order of the analogue Butterworth filter
n = ceil(log10((10^(As/10) - 1) / (10^(Ap/10) - 1)) / (2 * log10(fs_stop / fp)));
disp(['Order of the analogue Butterworth filter: ', num2str(n)]);

