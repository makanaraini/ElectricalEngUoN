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

% Find poles and zeros
[z_butter, p_butter, k_butter] = tf2zp(bd_butter, ad_butter);
[z_cheby1, p_cheby1, k_cheby1] = tf2zp(bd_cheby1, ad_cheby1);
[z_cheby2, p_cheby2, k_cheby2] = tf2zp(bd_cheby2, ad_cheby2);

% Display poles and zeros
disp('Poles and Zeros:');
disp('Butterworth Filter:');
disp('Zeros:');
disp(z_butter);
disp('Poles:');
disp(p_butter);

disp('Chebyshev Type I Filter:');
disp('Zeros:');
disp(z_cheby1);
disp('Poles:');
disp(p_cheby1);

disp('Chebyshev Type II Filter:');
disp('Zeros:');
disp(z_cheby2);
disp('Poles:');
disp(p_cheby2);

% Plot poles and zeros
figure;

subplot(3, 1, 1);
zplane(z_butter, p_butter);
title('Poles and Zeros of Butterworth Filter');
grid on;

subplot(3, 1, 2);
zplane(z_cheby1, p_cheby1);
title('Poles and Zeros of Chebyshev Type I Filter');
grid on;

subplot(3, 1, 3);
zplane(z_cheby2, p_cheby2);
title('Poles and Zeros of Chebyshev Type II Filter');
grid on;

