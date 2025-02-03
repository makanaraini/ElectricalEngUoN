%% Specifications
% Low-pass filter design specifications
passband_freq = 5000; % Pass-band frequency in Hz
passband_atten = 3; % Pass-band attenuation in dB
stopband_freq = 15000; % Stop-band frequency in Hz
stopband_atten = 40; % Stop-band attenuation in dB
% Sampling frequency (using 4 times the highest frequency)
sampling_freq = 4 * stopband_freq;
%% 1. Remez Iterative Algorithm
% Desired amplitude response (1 for pass-band, 0 for stop-band)
amplitude_desired = [1 0];
% Frequency bands corresponding to desired amplitudes
frequency_bands = [passband_freq stopband_freq];
% Allowable ripples (deviations from the ideal response)
ripple_values = [(1 - (10^(-passband_atten/20))) / (1 + (10^(-passband_atten/
20))), (10^(-stopband_atten/20))];
% Estimate the filter order and band edges
[remez_order, band_edges, amp_response, weights] = firpmord(frequency_bands,
amplitude_desired, ripple_values, sampling_freq);
disp(['Estimated Remez Filter Order: ', num2str(remez_order)])

% Setting the filter order (round up to an odd number if needed)
remez_order = remez_order + mod(remez_order, 2); % Ensures an even order for
better symmetry
disp(['Adjusted Remez Filter Order: ', num2str(remez_order)])

% Design the Remez filter
[remez_coeffs, error_val] = firpm(remez_order, band_edges, amp_response,
weights);
remez_filter_tf = tf(remez_coeffs, 1, 1/sampling_freq)

% Plot poles and zeros
figure;
zplane(remez_coeffs, 1);
title('Remez Filter Poles and Zeros');

% Plot impulse response
figure;
impz(remez_coeffs);
title('Remez Filter Impulse Response');

% Plot frequency response
figure;
freqz(remez_coeffs, 1, 1024, sampling_freq);
title('Remez Filter Frequency Response');

%% 2. Window Method
% a) Rectangular Window
% Normalized transition band
transition_band_rect = (stopband_freq - passband_freq) / sampling_freq;
% Calculate the minimum required filter length
min_length_rect = ceil((2 - transition_band_rect) / transition_band_rect)

filter_length_rect = max(25, min_length_rect) % Use the larger of 25 or the
calculated length

% Design the filter with a rectangular window
rect_coeffs = fir1(filter_length_rect, 2 * passband_freq / sampling_freq,
rectwin(filter_length_rect + 1))

rect_filter_tf = tf(rect_coeffs, 1, 1/sampling_freq)

% Plot poles and zeros
figure;
zplane(rect_coeffs, 1);
title('Rectangular Window Filter Poles and Zeros');

% Plot impulse response
figure;
impz(rect_coeffs);
title('Rectangular Window Filter Impulse Response');

% Plot frequency response
figure;
freqz(rect_coeffs, 1, 512, sampling_freq);
title('Rectangular Window Filter Frequency Response');

% b) Applying a Hanning Window
% Normalized transition band for Hanning
transition_band_hann = (stopband_freq - passband_freq) / sampling_freq;
% Minimum filter length for Hanning window

min_length_hann = ceil(4 / transition_band_hann);
filter_length_hann = max(25, min_length_hann);
% Design the filter with a Hanning window
hann_coeffs = fir1(filter_length_hann, 2 * passband_freq / sampling_freq,
hann(filter_length_hann + 1));
hann_filter_tf = tf(hann_coeffs, 1, 1/sampling_freq);
% Plot poles and zeros
figure;
zplane(hann_coeffs, 1);
title('Hanning Window Filter Poles and Zeros');

% Plot impulse response
figure;
impz(hann_coeffs);
title('Hanning Window Filter Impulse Response');

% Plot frequency response
figure;
freqz(hann_coeffs, 1, 512, sampling_freq);
title('Hanning Window Filter Frequency Response');

% c) Multiplying impulse response by a Hamming Window
[h_imp, sample_indices] = impz(rect_coeffs);
hamming_window = hamming(filter_length_rect + 1);
imp_response_modified = h_imp .* hamming_window;
% Plot modified impulse response
figure;

stem(sample_indices, imp_response_modified, 'Color', 'b');
title('Rectangular Window Impulse Response Modified by Hamming Window');
xlabel('n (samples)'); ylabel('Amplitude');

