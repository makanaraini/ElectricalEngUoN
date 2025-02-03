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
Hz = tf(Hznum, Hzden, 1 / f_samp); % Define the digital transfer function

% Calculate digital filter order
n_digital = length(Hznum) - 1;

%% Part (d): Frequency Response Plots for Analog and Digital Filters
% Digital filter frequency response plot
figure;
freqz(Hznum, Hzden, 512, f_samp);
title('Frequency Response of Digital Butterworth Filter');

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