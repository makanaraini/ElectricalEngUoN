num = [2];
den = [1 3 2];
H0 = tf(num, den)

p = pole(H0)

z = zero(H0)

% Sampling frequency for digital filter (following Nyquist Criterion)
fs = 5; % twice the highest frequency (2.5Hz)
% Obtain the z-transform using Impulse Invariance Method
[H1num, H1den] = impinvar(num, den, fs);
H1 = tf(H1num, H1den, 1/fs)

% Plotting the poles and zeros of the digital filter (Impulse Invariance)
figure;
zplane(H1num, H1den);
title('Poles and Zeros of Impulse Invariance Digital Transfer Function');

% Compute and plot the impulse response of H0
t = 0:0.01:10; % Time vector from 0 to 10 seconds with 0.01s step
figure;
impulse(H0, t);
title('Impulse Response of H_0(s)');
xlabel('Time (seconds)');
ylabel('h_0(t)');
grid on;

[H2num, H2den] = bilinear(num, den, fs);
H2 = tf(H2num, H2den, 1/fs)

% Plotting poles and zeros of the digital filter (Bilinear Transform)
figure;
zplane(H2num, H2den);
title('Poles and Zeros of Bilinear Transform Digital Transfer Function');

% Part (c): Impulse Response of H1 and H2
% Impulse response of H1
[impresp1, n1] = impz(H1num, H1den, 50);
figure;
stem(n1/fs, impresp1*fs, 'r'); % Scale to seconds and correct amplitude
hold on;
% Impulse response of H0
[impresp0, t0] = impulse(H0);
plot(t0, impresp0, 'b');
title('Impulse Invariance Digital Filter Impulse Response');
legend('h1[n]', 'h0(t)');
xlabel('Time (seconds)');
ylabel('Amplitude');
hold off;

% Impulse response of H2
[impresp2, n2] = impz(H2num, H2den, 50);
figure;
stem(n2/fs, impresp2*fs, 'Color', [0 0.6 0]); % Scale to seconds and correct
amplitude
hold on;
plot(t0, impresp0, 'b');
title('Bilinear Transform Digital Filter Impulse Response');
legend('h2[n]', 'h0(t)');
xlabel('Time (seconds)');
ylabel('Amplitude');
hold off;

% Part (d): Frequency Responses
% Analog filter frequency response
options = bodeoptions;
options.FreqUnits = 'Hz';
options.FreqScale = 'linear';
options.Xlim = [0, fs/2];
options.Grid = 'on';
figure;
bode(H0, options);
title('Analog Filter H0(s) Frequency Response');

% Frequency response of H1 (Impulse Invariance)
figure;
freqz(H1num, H1den, 512, fs);
title('Impulse Invariance Digital Filter H1(z) Frequency Response');

% Frequency response of H2 (Bilinear Transform)
figure;
freqz(H2num, H2den, 512, fs);
title('Bilinear Transform Digital Filter H2(z) Frequency Response');

% Combined magnitude responses
[h0, w0] = freqs(num, den, 0:(2*pi*fs/100):(2*pi*fs/2));
[h1, frq1] = freqz(H1num, H1den, 512, fs);
[h2, frq2] = freqz(H2num, H2den, 512, fs);
figure;
plot(w0/(2*pi), 20*log10(abs(h0)), 'b');
hold on;

plot(frq1, 20*log10(abs(h1)), 'r');
plot(frq2, 20*log10(abs(h2)), 'Color', [0 0.6 0]);
title('Magnitude Responses of Analog and Digital Filters');
legend('Analog', 'Impulse Invariance', 'Bilinear Transform', 'Location',
'southwest');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
grid on;
pbaspect([2 1 1]);
hold off;

% Combined phase responses
figure;
plot(w0/(2*pi), unwrap(angle(h0)) * 180/pi, 'b');
hold on;
plot(frq1, unwrap(angle(h1)) * 180/pi, 'r');
plot(frq2, unwrap(angle(h2)) * 180/pi, 'Color', [0 0.6 0], 'LineStyle',
'--');
title('Phase Responses of Analog and Digital Filters');
legend('Analog', 'Impulse Invariance', 'Bilinear Transform');
xlabel('Frequency (Hz)');
ylabel('Phase (degrees)');
grid on;
pbaspect([2 1 1]);

%Partial Fraction Decomposition of Digital filterrs
[r1, p1, k1] = residuez(H1num, H1den)

[r2, p2, k2] = residuez(H2num, H2den)

