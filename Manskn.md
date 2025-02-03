

**F17/2062/2020**


RAINI DANIEL MAKANA

# TELECOMMUNICATIONS LABORATORY REPORT
## Laboratory Exercises

Using the MATLAB Signal Processing Toolbox, design and implement both the low\-pass filters described below.

### Laboratory Exercise 1

Given an analog filter with the transfer function:


H₀(s) = 2 / (2 + 3s + s²)


Tasks:


a) Calculate the IIR digital filter transfer function H₁(z) associated with the analog filter H₀(s) using the impulse invariance method (impinvar). Determine the poles and zeros of the filter and represent them in the z\-plane using the zplane function.


b) Repeat the question using the bilinear transform to obtain H₂(z).


c) Plot the first 50 points of the impulse response of both H₁(z) and H₂(z) and compare them. How do the responses compare to those of H₀(s)?


d) Compare the frequency responses of the three filters. After finding the response of the analog filter H₀(s), compare the responses of the filters H₁(z) and H₂(z) after one period.


e) Use partial fraction decomposition of filters H₁(z) and H₂(z) to generate a parallel implementation of the filters using the residuez function.


f) Comment on the stability of the filters designed.

```matlab
% Define the passband frequency and convert to rad/s for design requirements
f_p = 5000; % Passband frequency in Hz
w_p = 2 * pi * f_p; % Passband angular frequency in rad/s

% Desired passband attenuation
a_p = 3; % in dB

% Define the stopband frequency and convert to rad/s
f_s = 15000; % Stopband frequency in Hz
w_s = 2 * pi * f_s; % Stopband angular frequency in rad/s

% Desired stopband attenuation
a_s = 40; % in dB

% Set sampling frequency, ensuring it is high enough to satisfy Nyquist criterion
f_samp = 4 * f_s; % in Hz

% Calculate normalized frequencies for digital filter design
f_pn = f_p * 2 / f_samp; % Normalized passband frequency
f_sn = f_s * 2 / f_samp; % Normalized stopband frequency

% Calculate Butterworth filter order and cutoff frequency
[n, w_n] = buttord(f_pn, f_sn, a_p, a_s);

% Determine precise cutoff frequency to meet passband specifications
w_cp = passband_spec_w_c(w_p, a_p, n); % Custom function for Butterworth cutoff

% Custom function for calculating cutoff frequency
function w_c = passband_spec_w_c(w_p, a_p, n)
    % Calculate cutoff frequency based on passband attenuation and filter order
    attenuation_linear = 10^(a_p / 10) - 1;
    w_c = w_p / (attenuation_linear^(1/(2 * n)));
end

%% Part (b): Plotting the Frequency Response of the Analog Filter
[Hsnum, Hsden] = butter(n, w_cp, 'low', 's'); % Analog Butterworth filter design
Hs = tf(Hsnum, Hsden); % Define the transfer function

% Configure bode options for frequency response plot
options = bodeoptions;
options.FreqUnits = 'Hz';
options.FreqScale = 'linear';
options.Xlim = [0, (f_samp / 2)];
options.Grid = 'on';

figure;
bode(Hs, options);
title('Frequency Response of Analog Butterworth Filter');

%% Part (c): Digital Filter Design Using Bilinear Transformation
[Hznum, Hzden] = bilinear(Hsnum, Hsden, f_samp); % Convert to digital filter
```

```matlabTextOutput
Warning: Matrix is close to singular or badly scaled. Results may be inaccurate. RCOND =  2.976260e-26.
Warning: Matrix is close to singular or badly scaled. Results may be inaccurate. RCOND =  2.976260e-26.
Warning: Matrix is close to singular or badly scaled. Results may be inaccurate. RCOND =  2.975765e-26.
Warning: Matrix is close to singular or badly scaled. Results may be inaccurate. RCOND =  2.975765e-26.
```

```matlab
Hz = tf(Hznum, Hzden, 1 / f_samp); % Define the digital transfer function

% Calculate digital filter order
n_digital = length(Hznum) - 1;

%% Part (d): Frequency Response Plots for Analog and Digital Filters
% Digital filter frequency response plot
figure;
freqz(Hznum, Hzden, 512, f_samp);
title('Frequency Response of Digital Butterworth Filter');
```

![figure_0.png](MKn_media/figure_0.png)

```matlab

% Compare Analog and Digital Butterworth Filter Responses
[h0, w0] = freqs(Hsnum, Hsden, (0:(2 * pi * f_samp / 100):(2 * pi * f_samp / 2))); 
[hz, frqz] = freqz(Hznum, Hzden, 512, f_samp);

% Magnitude responses plot
figure;
plot(w0 / (2 * pi), 20 * log10(abs(h0)), 'b', 'DisplayName', 'Analog');
hold on;
plot(frqz, 20 * log10(abs(hz)), 'r', 'DisplayName', 'Digital');
title('Magnitude Responses of Analog and Digital Butterworth Filters');
legend('Analog', 'Digital');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
grid on;
pbaspect([2 1 1]);
hold off;

% Phase responses plot
figure;
plot(w0 / (2 * pi), unwrap(angle(h0)) * 180 / pi, 'b', 'DisplayName', 'Analog');
hold on;
plot(frqz, unwrap(angle(hz)) * 180 / pi, 'r', 'DisplayName', 'Digital');
title('Phase Responses of Analog and Digital Butterworth Filters');
legend('Analog', 'Digital');
xlabel('Frequency (Hz)');
ylabel('Phase (degrees)');
grid on;
pbaspect([2 1 1]);
hold off;
```

![figure_1.png](MKn_media/figure_1.png)

![figure_2.png](MKn_media/figure_2.png)

![figure_3.png](MKn_media/figure_3.png)

![figure_4.png](MKn_media/figure_4.png)
### Laboratory Exercise 2(Synthesis of analogue and digital filters in the frequency domain) 

To build a low pass filter that has a pass\-band up to from 5kHz to 3dB and an attenuation of 40dB up to 15 kHz.


a) What is the order of the analogue Butterworth Filter,


b) Plot its frequency response.


c) If the bilinear transform is to be used to design the digital filter (bilinear), what is the order of the filter?


d) Find the frequency response of the digital filter and compare it with those of the analogue filter ().

```matlab
% Define the transfer function of the analog filter
num = 2; % Numerator coefficients of H0(s)
den = [1 3 2]; % Denominator coefficients of H0(s)
H0 = tf(num, den); % Create analog filter H0(s)

% Find poles and zeros of the analog filter
p = pole(H0); % Calculate poles of H0
z = zero(H0); % Calculate zeros of H0

% Set sampling frequency based on Nyquist Criterion
fs = 5; % Choose sampling frequency (safety factor included)

% Convert the analog filter to digital using Impulse Invariance method
[H1num, H1den] = impinvar(num, den, fs); % Impulse invariance conversion
H1 = tf(H1num, H1den, 1/fs); % Create digital filter H1(z)

% Plot poles and zeros of H1
figure;
zplane(H1num, H1den); % Z-plane plot for digital filter H1
title('Poles and Zeros of Impulse Invariance Digital Transfer Function');
```

![figure_5.png](MKn_media/figure_5.png)

```matlab

% Plot impulse response of the analog filter H0
t = 0:0.01:10; % Time vector for 10 seconds with 0.01 s steps
figure;
impulse(H0, t); % Impulse response of H0
title('Impulse Response of H_0(s)');
xlabel('Time (seconds)');
ylabel('h_0(t)');
grid on;

% Convert the analog filter to digital using Bilinear Transform
[H2num, H2den] = bilinear(num, den, fs); % Bilinear transform conversion
H2 = tf(H2num, H2den, 1/fs); % Create digital filter H2(z)

% Plot poles and zeros of H2
figure;
zplane(H2num, H2den); % Z-plane plot for digital filter H2
title('Poles and Zeros of Bilinear Transform Digital Transfer Function');
```

![figure_6.png](MKn_media/figure_6.png)

```matlab

% Compute and plot impulse responses of H1 and H0
[impresp1, n1] = impz(H1num, H1den, 50); % Impulse response of H1
figure;
stem(n1/fs, impresp1*fs, 'r'); % Digital impulse response in red
hold on;
[impresp0, t0] = impulse(H0); % Impulse response of H0
plot(t0, impresp0, 'b'); % Overlay analog impulse response in blue
title('Impulse Response Comparison of H_0 and H_1');
legend('h_1[n] (Impulse Invariance)', 'h_0(t)');
xlabel('Time (seconds)');
ylabel('Amplitude');
hold off;
```

![figure_7.png](MKn_media/figure_7.png)

```matlab

% Plot impulse response of H2 and compare with H0
[impresp2, n2] = impz(H2num, H2den, 50); % Impulse response of H2
figure;
stem(n2/fs, impresp2*fs, 'Color', [0 0.6 0]); % Plot H2 in green
hold on;
plot(t0, impresp0, 'b'); % Overlay analog impulse response in blue
title('Impulse Response Comparison of H_0 and H_2');
legend('h_2[n] (Bilinear Transform)', 'h_0(t)');
xlabel('Time (seconds)');
ylabel('Amplitude');
hold off;
```

![figure_8.png](MKn_media/figure_8.png)

```matlab

% Frequency Response Analysis
options = bodeoptions; % Create options for Bode plot
options.FreqUnits = 'Hz'; % Set frequency units to Hz
options.FreqScale = 'linear'; % Set frequency scale to linear
options.Xlim = [0, fs/2]; % Limit frequency range to Nyquist frequency
options.Grid = 'on'; % Enable grid for plots

% Analog filter frequency response
figure;
bode(H0, options); % Bode plot for H0
title('Frequency Response of Analog Filter H_0(s)');
```

![figure_9.png](MKn_media/figure_9.png)

```matlab

% Frequency response of H1
figure;
freqz(H1num, H1den, 512, fs); % Frequency response of H1
title('Frequency Response of H_1(z) (Impulse Invariance)');
```

![figure_10.png](MKn_media/figure_10.png)

```matlab

% Frequency response of H2
figure;
freqz(H2num, H2den, 512, fs); % Frequency response of H2
title('Frequency Response of H_2(z) (Bilinear Transform)');
```

![figure_11.png](MKn_media/figure_11.png)

```matlab

% Combined Magnitude Responses
[h0, w0] = freqs(num, den, 0:(2*pi*fs/100):(2*pi*fs/2)); % Frequency response of H0
[h1, frq1] = freqz(H1num, H1den, 512, fs); % Frequency response of H1
[h2, frq2] = freqz(H2num, H2den, 512, fs); % Frequency response of H2

figure;
plot(w0/(2*pi), 20*log10(abs(h0)), 'b'); % Analog response in blue
hold on;
plot(frq1, 20*log10(abs(h1)), 'r'); % H1 response in red
plot(frq2, 20*log10(abs(h2)), 'Color', [0 0.6 0]); % H2 response in green
title('Magnitude Responses of Analog and Digital Filters');
legend('Analog', 'Impulse Invariance', 'Bilinear Transform', 'Location', 'southwest');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
grid on;
pbaspect([2 1 1]); % Aspect ratio for the plot
hold off;
```

![figure_12.png](MKn_media/figure_12.png)

```matlab

% Combined Phase Responses
figure;
plot(w0/(2*pi), unwrap(angle(h0)) * 180/pi, 'b'); % Analog phase in blue
hold on;
plot(frq1, unwrap(angle(h1)) * 180/pi, 'r'); % H1 phase in red
plot(frq2, unwrap(angle(h2)) * 180/pi, 'Color', [0 0.6 0], 'LineStyle', '--'); % H2 phase in green
title('Phase Responses of Analog and Digital Filters');
legend('Analog', 'Impulse Invariance', 'Bilinear Transform');
xlabel('Frequency (Hz)');
ylabel('Phase (degrees)');
grid on;
pbaspect([2 1 1]); % Aspect ratio for the plot
```

![figure_13.png](MKn_media/figure_13.png)

```matlab

% Partial Fraction Decomposition of Digital Filters
[r1, p1, k1] = residuez(H1num, H1den); % Decomposition of H1
[r2, p2, k2] = residuez(H2num, H2den); % Decomposition of H2

```
### Laboratory Exercise 3 I: Synthesis of Digital Filters in the Analog Frequency Domain

Objective: To build a low\-pass filter using the following methods:


1. Infinite Impulse Response (IIR) Synthesis


   \- i. Butterworth Filter


   \- ii. Chebyshev Type I


   \- iii. Chebyshev Type II


Tasks:


a) Find the least order of the filters that satisfy the design criteria using the following functions:


   \- Butterworth: buttord


   \- Chebyshev Type I: cheb1ord


   \- Chebyshev Type II: cheb2ord


b) Recover the associated digital transfer function in the z\-domain using:


   \- Butterworth: butter


   \- Chebyshev Type I: cheby1


   \- Chebyshev Type II: cheby2


c) Find the poles and zeros of each filter and plot them using the zplane function.


d) Comment on the stability of each filter based on the pole\-zero plots.


e) Plot the frequency response of each of the three filters using the freqz function and comment on your observations.


f) Plot the frequency response of all three filters on one graph using the freqz function. Zoom in on specific areas to check if they fulfill the design criteria.

```matlab
% Specifications for Low-Pass Filter Design
f_p = 5000; % Passband frequency in Hz
w_p = 2 * pi * f_p; % Angular passband frequency
a_p = 3; % Passband attenuation in dB

f_s = 15000; % Stopband frequency in Hz
w_s = 2 * pi * f_s; % Angular stopband frequency
a_s = 40; % Stopband attenuation in dB

% Sampling frequency (at least twice the highest frequency to satisfy Nyquist criterion)
f_samp = 4 * f_s; % Sampling frequency in Hz

% Normalize passband and stopband frequencies to Nyquist frequency for digital calculations
w_p_norm = f_p / (f_samp / 2);
w_s_norm = f_s / (f_samp / 2);

% Designing the analog Butterworth filter
% Compute filter order and cutoff frequency
[n, w_cs] = buttord(w_p_norm, w_s_norm, a_p, a_s);

% Calculate exact cutoff frequency to meet the passband specs
w_cp = passband_spec_w_c(w_p, a_p, n); % Custom function for cutoff frequency calculation

% Define the custom function for cutoff frequency calculation (w_cp)
function w_c = passband_spec_w_c1(w_p, a_p, n)
    % Calculates cutoff frequency based on passband specs
    w_c = w_p / (10^(a_p / 10) - 1)^(1 / (2 * n));
end

% Get transfer function of the analog Butterworth filter
[Hsnum, Hsden] = butter(n, w_cp, 's');
Hs = tf(Hsnum, Hsden); % Analog filter transfer function

% Plot frequency response of the analog Butterworth filter
figure;
bode(Hs, {0, f_samp/2 * 2 * pi});
title('Analog Butterworth Filter Frequency Response');
```

![figure_14.png](MKn_media/figure_14.png)

```matlab

% Convert analog Butterworth filter to a digital filter using bilinear transform
[Hznum, Hzden] = bilinear(Hsnum, Hsden, f_samp);
```

```matlabTextOutput
Warning: Matrix is close to singular or badly scaled. Results may be inaccurate. RCOND =  2.976260e-26.
Warning: Matrix is close to singular or badly scaled. Results may be inaccurate. RCOND =  2.976260e-26.
Warning: Matrix is close to singular or badly scaled. Results may be inaccurate. RCOND =  2.975765e-26.
Warning: Matrix is close to singular or badly scaled. Results may be inaccurate. RCOND =  2.975765e-26.
```

```matlab
Hz = tf(Hznum, Hzden, 1/f_samp); % Digital filter transfer function

% Plot frequency response of the digital Butterworth filter
figure;
freqz(Hznum, Hzden, 1024, f_samp);
title('Digital Butterworth Filter Frequency Response');
```

![figure_15.png](MKn_media/figure_15.png)

```matlab

% Compare frequency responses of analog and digital filters
[h0, w0] = freqs(Hsnum, Hsden, linspace(0, f_samp, 512) * 2 * pi);
[hz, frqz] = freqz(Hznum, Hzden, 512, f_samp);

% Plot magnitude responses
figure;
plot(w0/(2*pi), 20*log10(abs(h0)), 'b', 'DisplayName', 'Analog');
hold on;
plot(frqz, 20*log10(abs(hz)), 'r', 'DisplayName', 'Digital');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
title('Magnitude Responses of Analog and Digital Butterworth Filters');
legend;
grid on;
hold off;
```

![figure_16.png](MKn_media/figure_16.png)

```matlab

% Plot phase responses
figure;
plot(w0/(2*pi), unwrap(angle(h0)) * 180/pi, 'b', 'DisplayName', 'Analog');
hold on;
plot(frqz, unwrap(angle(hz)) * 180/pi, 'r', 'DisplayName', 'Digital');
xlabel('Frequency (Hz)');
ylabel('Phase (degrees)');
title('Phase Responses of Analog and Digital Butterworth Filters');
legend;
grid on;
hold off;
```

![figure_17.png](MKn_media/figure_17.png)


### Laboratory 3 II  

Finite Impulse Response Synthesis  


i. Remez Iterative Algorithm  


a) Estimate the least order of the filter using the `remezord` function.  


b) Calculate and plot the impulse response of the filter.  


c) Find the poles and zeros and plot them using the `zplane` function.  


d) Comment on the stability of the filters.  


e) Plot the frequency response of the filters and check if it meets the design specifications using the `freqz` function.  


ii. Windows Method  


a) For a rectangular filter using 25 points, find the impulse response of the filter.  


b) Calculate and plot the impulse response of the filter.  


c) Find the poles and zeros and plot them using the `zplane` function.  


d) Comment on the stability of the filters.  


e) Plot the frequency response of the filter and check if it meets the design specifications using the `freqz` function.  


f) Multiply the impulse response with a window of your choice (Hamming, Kaiser, etc.).  


g) Observe the effect of windows on the response.

```matlab
%% Specifications
% Low-pass filter design specifications
passband_freq = 5000; % Pass-band frequency in Hz
passband_atten = 3; % Pass-band attenuation in dB
stopband_freq = 15000; % Stop-band frequency in Hz
stopband_atten = 40; % Stop-band attenuation in dB

% Define sampling frequency (4 times the highest frequency to satisfy Nyquist criterion)
sampling_freq = 4 * stopband_freq;

%% 1. Remez Iterative Algorithm
% Desired amplitude response (1 for pass-band, 0 for stop-band)
amplitude_desired = [1 0];

% Frequency bands corresponding to the desired amplitudes
frequency_bands = [passband_freq stopband_freq];

% Calculate allowable ripples based on attenuation specifications
ripple_values = [(1 - (10^(-passband_atten / 20))) / (1 + (10^(-passband_atten / 20))), (10^(-stopband_atten / 20))];

% Estimate filter order and corresponding band edges using firpmord
[remez_order, band_edges, amp_response, weights] = firpmord(frequency_bands, amplitude_desired, ripple_values, sampling_freq);
disp(['Estimated Remez Filter Order: ', num2str(remez_order)]);
```

```matlabTextOutput
Estimated Remez Filter Order: 5
```

```matlab

% Adjust the filter order to be even for better symmetry
remez_order = remez_order + mod(remez_order, 2);
disp(['Adjusted Remez Filter Order: ', num2str(remez_order)]);
```

```matlabTextOutput
Adjusted Remez Filter Order: 6
```

```matlab

% Design the Remez filter with the calculated coefficients
[remez_coeffs, error_val] = firpm(remez_order, band_edges, amp_response, weights);
remez_filter_tf = tf(remez_coeffs, 1, 1 / sampling_freq);

% Plot poles and zeros of the Remez filter
figure;
zplane(remez_coeffs, 1);
title('Remez Filter Poles and Zeros');
```

![figure_18.png](MKn_media/figure_18.png)

```matlab

% Plot the impulse response of the Remez filter
figure;
impz(remez_coeffs);
title('Remez Filter Impulse Response');
```

![figure_19.png](MKn_media/figure_19.png)

```matlab

% Plot the frequency response of the Remez filter
figure;
freqz(remez_coeffs, 1, 1024, sampling_freq);
title('Remez Filter Frequency Response');
```

![figure_20.png](MKn_media/figure_20.png)

```matlab

%% 2. Window Method
% a) Rectangular Window
% Calculate normalized transition band
transition_band_rect = (stopband_freq - passband_freq) / sampling_freq;

% Calculate minimum required filter length
min_length_rect = ceil((2 - transition_band_rect) / transition_band_rect);
filter_length_rect = max(25, min_length_rect); % Use maximum of 25 or calculated length

% Design the filter using a rectangular window
rect_coeffs = fir1(filter_length_rect, 2 * passband_freq / sampling_freq, rectwin(filter_length_rect + 1));
rect_filter_tf = tf(rect_coeffs, 1, 1 / sampling_freq);

% Plot poles and zeros of the rectangular window filter
figure;
zplane(rect_coeffs, 1);
title('Rectangular Window Filter Poles and Zeros');
```

![figure_21.png](MKn_media/figure_21.png)

```matlab

% Plot the impulse response of the rectangular window filter
figure;
impz(rect_coeffs);
title('Rectangular Window Filter Impulse Response');
```

![figure_22.png](MKn_media/figure_22.png)

```matlab

% Plot the frequency response of the rectangular window filter
figure;
freqz(rect_coeffs, 1, 512, sampling_freq);
title('Rectangular Window Filter Frequency Response');
```

![figure_23.png](MKn_media/figure_23.png)

```matlab

% b) Applying a Hanning Window
% Calculate normalized transition band for Hanning window
transition_band_hann = (stopband_freq - passband_freq) / sampling_freq;

% Minimum filter length for Hanning window
min_length_hann = ceil(4 / transition_band_hann);
filter_length_hann = max(25, min_length_hann);

% Design the filter using a Hanning window
hann_coeffs = fir1(filter_length_hann, 2 * passband_freq / sampling_freq, hann(filter_length_hann + 1));
hann_filter_tf = tf(hann_coeffs, 1, 1 / sampling_freq);

% Plot poles and zeros of the Hanning window filter
figure;
zplane(hann_coeffs, 1);
title('Hanning Window Filter Poles and Zeros');
```

![figure_24.png](MKn_media/figure_24.png)

```matlab

% Plot the impulse response of the Hanning window filter
figure;
impz(hann_coeffs);
title('Hanning Window Filter Impulse Response');
```

![figure_25.png](MKn_media/figure_25.png)

```matlab

% Plot the frequency response of the Hanning window filter
figure;
freqz(hann_coeffs, 1, 512, sampling_freq);
title('Hanning Window Filter Frequency Response');
```

![figure_26.png](MKn_media/figure_26.png)

```matlab

% c) Modifying Impulse Response with Hamming Window
[h_imp, sample_indices] = impz(rect_coeffs); % Impulse response of the rectangular window filter
hamming_window = hamming(filter_length_rect + 1); % Create Hamming window
imp_response_modified = h_imp .* hamming_window; % Modify impulse response by Hamming window

% Plot the modified impuLlse response
figure;
stem(sample_indices, imp_response_modified, 'Color', 'b');
title('Rectangular Window Impulse Response Modified by Hamming Window');
xlabel('n (samples)');
ylabel('Amplitude');
```

![figure_27.png](MKn_media/figure_27.png)
