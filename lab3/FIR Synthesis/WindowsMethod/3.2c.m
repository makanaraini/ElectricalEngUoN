% Specifications
N = 25; % Number of points in the filter

% Create a rectangular window (boxcar filter)
h_rectangular = ones(N, 1) / N; % Normalize the impulse response

% Calculate the impulse response
impulse_length = 50; % Length of impulse response for visualization
impulse = [1; zeros(impulse_length-1, 1)]; % Create an impulse signal
h_response = conv(h_rectangular, impulse); % Convolve with impulse

% Find poles and zeros
[Z, P, K] = tf2zp(h_rectangular, 1); % Zeros, poles, and gain

% Display poles and zeros
disp('Poles and Zeros:');
disp('Zeros:');
disp(Z);
disp('Poles:');
disp(P);

% Plot poles and zeros
figure;
zplane(Z, P);
title('Poles and Zeros of the Rectangular Filter');
grid on;

