% Specifications
N = 25; % Number of points in the filter

% Create a rectangular window (boxcar filter)
h_rectangular = ones(N, 1) / N; % Normalize the impulse response

% Calculate the frequency response of the rectangular filter
[H_rectangular, f_rectangular] = freqz(h_rectangular, 1, 512, 'whole'); % Frequency response

% Choose a window (Hamming window in this case)
window = hamming(N); % Create a Hamming window

% Multiply the impulse response with the window
h_windowed = h_rectangular .* window; % Apply the window to the impulse response

% Calculate the frequency response of the windowed filter
[H_windowed, f_windowed] = freqz(h_windowed, 1, 512, 'whole'); % Frequency response

% Convert frequency to Hz for plotting
fs = 30000; % Sampling frequency (30 kHz)
f_hz_rectangular = f_rectangular * fs / (2 * pi);
f_hz_windowed = f_windowed * fs / (2 * pi);

% Plot the frequency responses
figure;
semilogx(f_hz_rectangular, 20*log10(abs(H_rectangular)), 'b', 'LineWidth', 1.5); % Rectangular filter
hold on;
semilogx(f_hz_windowed, 20*log10(abs(H_windowed)), 'r', 'LineWidth', 1.5); % Windowed filter

% Graph settings
title('Frequency Response Comparison: Rectangular vs. Windowed Filter');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
grid on;
axis([10 15000 -60 5]); % Set axis limits
legend('Rectangular Filter', 'Windowed Filter (Hamming)', 'Location', 'Best');
hold off;

