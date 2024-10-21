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

% Calculate the frequency response
[H, f] = freqz(b, 1, 512, 'whole'); % Frequency response

% Convert frequency to Hz for plotting
f_hz = f * fs / (2 * pi);

% Plot the frequency response
figure;
semilogx(f_hz, 20*log10(abs(H)), 'b', 'LineWidth', 1.5); % Convert to dB
hold on;

% Marking the design criteria
yline(-3, 'r--', '3 dB Point'); % Mark the 3 dB point
yline(-43, 'g--', '40 dB Attenuation'); % Mark the 40 dB attenuation point

% Graph settings
title('Frequency Response of the Low-Pass Filter');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
grid on;
axis([10 15000 -60 5]); % Set axis limits
legend('Frequency Response', '3 dB Point', '40 dB Attenuation', 'Location', 'Best');
hold off;

