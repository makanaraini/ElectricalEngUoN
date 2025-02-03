% 1. Initialization
% ---------------------------------------------------------
% Passband frequency and attenuation
f_p = 5000; % Frequency in Hertz
a_p = 3; % Attenuation in dB
w_p = 2 * pi * f_p; % Angular frequency
% Stopband frequency and attenuation
f_s = 15000; % Frequency in Hertz
a_s = 40; % Attenuation in dB
% Sampling frequency
f_samp = 4 * f_s; % Sampling rate (Nyquist rate)
% Normalized passband and stopband frequencies
f_pn = f_p * 2 / f_samp % Passband normalized frequency
f_sn = f_s * 2 / f_samp % Stopband normalized frequency
% 2. Filter Order and Cutoff Frequency Calculation
% ---------------------------------------------------------
% Chebyshev Type 1 filter design
[n_c1, w_n_c1] = cheb1ord(f_pn, f_sn, a_p, a_s)
% Chebyshev Type 2 filter design
[n_c2, w_n_c2] = cheb2ord(f_pn, f_sn, a_p, a_s)
% Butterworth filter design
[n_b, ~] = buttord(f_pn, f_sn, a_p, a_s)
w_n_b = passband_spec_w_c(w_p, a_p, n_b) / (pi * f_samp) % Custom function
to calculate cutoff
% 3. Digital Filter Design
% ---------------------------------------------------------
% Butterworth digital filter design
[Hz_b_num, Hz_b_den] = butter(n_b, w_n_b, 'low');
Hz_b = tf(Hz_b_num, Hz_b_den, 1/f_samp) % Transfer function
% Chebyshev Type 1 digital filter design
[Hz_c1_num, Hz_c1_den] = cheby1(n_c1, a_p, w_n_c1, 'low');
Hz_c1 = tf(Hz_c1_num, Hz_c1_den, 1/f_samp) % Transfer function
% Chebyshev Type 2 digital filter design
[Hz_c2_num, Hz_c2_den] = cheby2(n_c2, a_s, w_n_c2, 'low');
Hz_c2 = tf(Hz_c2_num, Hz_c2_den, 1/f_samp) % Transfer function



% 4. Poles and Zeros Plotting
% ---------------------------------------------------------
% Butterworth filter
figure;
zplane(Hz_b_num, Hz_b_den);
title('Poles and Zeros of Butterworth Digital Filter');
grid on;

% Chebyshev Type 1 filter
figure;
zplane(Hz_c1_num, Hz_c1_den);
title('Poles and Zeros of Chebyshev Type 1 Digital Filter');
grid on;

% Chebyshev Type 2 filter
figure;
zplane(Hz_c2_num, Hz_c2_den);
title('Poles and Zeros of Chebyshev Type 2 Digital Filter');
grid on;

% 5. Frequency Response Analysis
% ---------------------------------------------------------
% Frequency responses
figure;
freqz(Hz_b_num, Hz_b_den, 512, f_samp);
title('Frequency Response of Butterworth Digital Filter');
grid on;

figure;
freqz(Hz_c1_num, Hz_c1_den, 512, f_samp);
title('Frequency Response of Chebyshev Type 1 Digital Filter');
grid on;

figure;
freqz(Hz_c2_num, Hz_c2_den, 512, f_samp);
title('Frequency Response of Chebyshev Type 2 Digital Filter');
grid on;

% 6. Combined Frequency Response Plotting
% ---------------------------------------------------------
% Magnitude responses
[h_b, freq_b] = freqz(Hz_b_num, Hz_b_den, 512, f_samp);
[h_c1, frq_c1] = freqz(Hz_c1_num, Hz_c1_den, 512, f_samp);
[h_c2, frq_c2] = freqz(Hz_c2_num, Hz_c2_den, 512, f_samp);
figure;
plot(freq_b, 20*log10(abs(h_b)), 'b', 'DisplayName', 'Butterworth');
hold on;
plot(frq_c1, 20*log10(abs(h_c1)), 'r', 'DisplayName', 'Chebyshev Type 1');
plot(frq_c2, 20*log10(abs(h_c2)), 'g', 'DisplayName', 'Chebyshev Type 2');
title('Magnitude Responses of Digital Filters');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
legend;
grid on;
hold off;

% Phase responses
figure;
plot(freq_b, unwrap(angle(h_b)) * 180/pi, 'b', 'DisplayName', 'Butterworth');
hold on;
plot(frq_c1, unwrap(angle(h_c1)) * 180/pi, 'r', 'DisplayName', 'Chebyshev
Type 1');
plot(frq_c2, unwrap(angle(h_c2)) * 180/pi, 'g', 'DisplayName', 'Chebyshev
Type 2');
title('Phase Responses of Digital Filters');
xlabel('Frequency (Hz)');
ylabel('Phase (Degrees)');
legend;
grid on;
hold off;

% 7. Custom Functions
% ---------------------------------------------------------
% custom functions used in the script, such as .
function pass_w_c = passband_spec_w_c(w_p, a_p, n)
pass_w_c = (10^(a_p/10))-1;
pass_w_c = pass_w_c ^ (1/(2*n));
pass_w_c = w_p / pass_w_c;
end
function plot_lpf_target_spectral_response()
hold on;
xl = xlim;
x_pass = [xl(1) 5000 5000];
y_pass = [-3 -3 -150];
x_stop = [15000 15000 xl(2)];
y_stop = [0 -40 -40];
plot(x_pass, y_pass, 'Color',[0.5 0.5 0], 'LineStyle','--');
plot(x_stop, y_stop, 'Color',[0.5 0.5 0], 'LineStyle','--');
hold off;
end

