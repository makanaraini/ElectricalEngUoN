% Define the analogue filter transfer function H0(s)
num = [2]; % Numerator coefficients
den = [1 3 1]; % Denominator coefficients (s^2 + 3s + 2)

% Calculate the poles and zeros of the analogue filter
[z, p, k] = tf2zp(num, den); % Zeros, poles, and gain
disp('Zeros of H0(s):');
disp(z);
disp('Poles of H0(s):');
disp(p);

% Convert to IIR digital filter using bilinear transform
fs = 10; % Sampling frequency
[bd, ad] = bilinear(num, den, fs); % Digital filter coefficients using bilinear transform

% Calculate the poles and zeros of the digital filter
[zd, pd, kd] = tf2zp(bd, ad); % Zeros, poles, and gain of digital filter
disp('Zeros of H2(z):');
disp(zd);
disp('Poles of H2(z):');
disp(pd);

% Plot the poles and zeros in the z-plane
figure;
zplane(zd, pd);
title('Poles and Zeros of H2(z)');
grid on;

