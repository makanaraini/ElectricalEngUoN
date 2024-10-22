% Specifications
N = 25; % Number of points in the filter

% Create a rectangular window (boxcar filter)
h_rectangular = ones(N, 1) / N; % Normalize the impulse response

% Calculate the impulse response
impulse_length = 50; % Length of impulse response for visualization
impulse = [1; zeros(impulse_length-1, 1)]; % Create an impulse signal
h_response = conv(h_rectangular, impulse); % Convolve with impulse

% Plot the impulse response
figure;
stem(0:length(h_response)-1, h_response, 'filled');
title('Impulse Response of the Rectangular Filter');
xlabel('Samples');
ylabel('Amplitude');
grid on;

