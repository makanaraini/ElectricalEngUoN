% Define the analogue filter transfer function H0(s)
num = [2]; % Numerator coefficients
den = [1 3 1]; % Denominator coefficients (s^2 + 3s + 2)

% Convert to IIR digital filter using impulse invariance
fs = 10; % Sampling frequency
[bd1, ad1] = impinvar(num, den, fs); % Digital filter coefficients for H1(z)

% Convert to IIR digital filter using bilinear transform
[bd2, ad2] = bilinear(num, den, fs); % Digital filter coefficients for H2(z)

% Partial fraction decomposition for H1(z)
[R1, P1, K1] = residuez(bd1, ad1); % Residues, poles, and direct term for H1(z)

% Partial fraction decomposition for H2(z)
[R2, P2, K2] = residuez(bd2, ad2); % Residues, poles, and direct term for H2(z)

% Display results for H1(z)
disp('Partial Fraction Decomposition of H1(z):');
disp('Residues (R1):');
disp(R1);
disp('Poles (P1):');
disp(P1);
disp('Direct Term (K1):');
disp(K1);

% Display results for H2(z)
disp('Partial Fraction Decomposition of H2(z):');
disp('Residues (R2):');
disp(R2);
disp('Poles (P2):');
disp(P2);
disp('Direct Term (K2):');
disp(K2);

% Generate parallel implementation for H1(z)
% The output can be computed as:
% y[n] = sum(R1(i) * x[n] / (1 - P1(i) * z^(-1))) + K1
% where x[n] is the input signal

% Generate parallel implementation for H2(z)
% The output can be computed similarly:
% y[n] = sum(R2(i) * x[n] / (1 - P2(i) * z^(-1))) + K2

% Example input signal for testing
n = 0:49; % Sample indices
x = sin(2 * pi * 0.1 * n); % Example input signal (sine wave)

% Initialize output signals
y1 = zeros(size(x)); % Output for H1(z)
y2 = zeros(size(x)); % Output for H2(z)

% Compute output for H1(z) using parallel implementation
for i = 1:length(R1)
    % Compute the filter response for each residue and pole
    y1 = y1 + R1(i) * filter([1], [1 -P1(i)], x); % Parallel implementation
end
y1 = y1 + K1; % Add direct term

% Compute output for H2(z) using parallel implementation
for i = 1:length(R2)
    % Compute the filter response for each residue and pole
    y2 = y2 + R2(i) * filter([1], [1 -P2(i)], x); % Parallel implementation
end
y2 = y2 + K2; % Add direct term

% Plot the outputs for comparison
figure;

subplot(2, 1, 1);
plot(n, y1);
title('Output of H1(z) using Parallel Implementation');
xlabel('Samples');
ylabel('Amplitude');
grid on;

subplot(2, 1, 2);
plot(n, y2);
title('Output of H2(z) using Parallel Implementation');
xlabel('Samples');
ylabel('Amplitude');
grid on;

