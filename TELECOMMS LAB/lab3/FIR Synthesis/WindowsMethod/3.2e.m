% Specifications
N = 25; % Number of points in the filter

% Create a rectangular window (boxcar filter)
h_rectangular = ones(N, 1) / N; % Normalize the impulse response

% Calculate the frequency response
[H, f] = freqz(h_rectangular, 1, 512, 'whole'); % Frequency response

% Convert frequency to Hz for plotting
fs = 30000; % Sampling frequency (30 kHz)
f_hz = f * fs / (2 * pi);

% Plot the frequency response
figure;
semilogx(f_hz, 20*log10(abs(H)), 'b', 'LineWidth', 1.5); % Convert to dB
hold on;

% Marking the design criteria
yline(-3, 'r--', '3 dB Point'); % Mark the 3 dB point
yline(-43, 'g--', '40 dB Attenuation'); % Mark the 40 dB attenuation point

% Graph settings
title('Frequency Response of the Rectangular Filter');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
grid on;
axis([10 15000 -60 5]); % Set axis limits
legend('Frequency Response', '3 dB Point', '40 dB Attenuation', 'Location', 'Best');
hold off;

