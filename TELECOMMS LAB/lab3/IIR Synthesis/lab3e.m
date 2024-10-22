% Specifications
fs = 30000; % Sampling frequency (30 kHz)
fp = 5000;  % Pass-band frequency (5 kHz)
fs_stop = 15000; % Stop-band frequency (15 kHz)
Ap = 3;     % Pass-band ripple (3 dB)
As = 40;    % Stop-band attenuation (40 dB)

% Normalized frequencies
Wn = fp / (fs / 2); % Normalized pass-band frequency
Ws = fs_stop / (fs / 2); % Normalized stop-band frequency

% Calculate the order of the Butterworth filter
[n_butter, Wn_butter] = buttord(Wn, Ws, Ap, As);
disp(['Least order of the Butterworth filter: ', num2str(n_butter)]);

% Calculate the order of the Chebyshev Type I filter
[n_cheby1, Wn_cheby1] = cheb1ord(Wn, Ws, Ap, As);
disp(['Least order of the Chebyshev Type I filter: ', num2str(n_cheby1)]);

% Calculate the order of the Chebyshev Type II filter
[n_cheby2, Wn_cheby2] = cheb2ord(Wn, Ws, Ap, As);
disp(['Least order of the Chebyshev Type II filter: ', num2str(n_cheby2)]);

% Design the Butterworth filter
[bd_butter, ad_butter] = butter(n_butter, Wn_butter); % Digital Butterworth filter

% Design the Chebyshev Type I filter
[bd_cheby1, ad_cheby1] = cheby1(n_cheby1, Ap, Wn_cheby1); % Digital Chebyshev Type I filter

% Design the Chebyshev Type II filter
[bd_cheby2, ad_cheby2] = cheby2(n_cheby2, As, Wn_cheby2); % Digital Chebyshev Type II filter

% Frequency response of the filters
[H_butter, f_butter] = freqz(bd_butter, ad_butter, 512, 'whole'); % Butterworth
[H_cheby1, f_cheby1] = freqz(bd_cheby1, ad_cheby1, 512, 'whole'); % Chebyshev Type I
[H_cheby2, f_cheby2] = freqz(bd_cheby2, ad_cheby2, 512, 'whole'); % Chebyshev Type II

% Plot the frequency responses
figure;

subplot(3, 1, 1);
semilogx(f_butter * fs / (2 * pi), 20*log10(abs(H_butter))); % Convert to dB
title('Frequency Response of Butterworth Filter');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
grid on;
axis([10 15000 -60 5]); % Set axis limits
yline(-3, 'r--', '3 dB Point'); % Mark the 3 dB point
yline(-43, 'g--', '40 dB Attenuation'); % Mark the 40 dB attenuation point

subplot(3, 1, 2);
semilogx(f_cheby1 * fs / (2 * pi), 20*log10(abs(H_cheby1))); % Convert to dB
title('Frequency Response of Chebyshev Type I Filter');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
grid on;
axis([10 15000 -60 5]); % Set axis limits
yline(-3, 'r--', '3 dB Point'); % Mark the 3 dB point
yline(-43, 'g--', '40 dB Attenuation'); % Mark the 40 dB attenuation point

subplot(3, 1, 3);
semilogx(f_cheby2 * fs / (2 * pi), 20*log10(abs(H_cheby2))); % Convert to dB
title('Frequency Response of Chebyshev Type II Filter');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
grid on;
axis([10 15000 -60 5]); % Set axis limits
yline(-3, 'r--', '3 dB Point'); % Mark the 3 dB point
yline(-43, 'g--', '40 dB Attenuation'); % Mark the 40 dB attenuation point

