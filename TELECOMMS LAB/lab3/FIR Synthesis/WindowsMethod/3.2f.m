% Specifications
N = 25; % Number of points in the filter

% Create a rectangular window (boxcar filter)
h_rectangular = ones(N, 1) / N; % Normalize the impulse response

% Calculate the impulse response
impulse_length = 50; % Length of impulse response for visualization
impulse = [1; zeros(impulse_length-1, 1)]; % Create an impulse signal
h_response = conv(h_rectangular, impulse); % Convolve with impulse

% Choose a window (Hamming window in this case)
window = hamming(N); % Create a Hamming window

% Multiply the impulse response with the window
h_windowed = h_response(1:N) .* window; % Apply the window to the impulse response

% Plot the original and windowed impulse responses
figure;

subplot(2, 1, 1);
stem(0:length(h_response)-1, h_response, 'filled');
title('Impulse Response of the Rectangular Filter');
xlabel('Samples');
ylabel('Amplitude');
grid on;

subplot(2, 1, 2);
stem(0:N-1, h_windowed, 'filled');
title('Windowed Impulse Response (Hamming Window)');
xlabel('Samples');
ylabel('Amplitude');
grid on;

