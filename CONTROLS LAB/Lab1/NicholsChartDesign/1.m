% Define the parameters
s = tf('s');
K = 1; % Initial guess for K
desired_Mp = 1.4; % Desired resonant peak in dB

% Define the open-loop transfer function
G = K / (s * (1 + 200) * (1 + s/250));

% Create a loop to find the appropriate K
for K = 0.1:0.1:10 % Adjust the range and step as needed
    G = K / (s * (1 + 200) * (1 + s/250));
    [mag, phase, w] = nichols(G); % Get magnitude and phase
    Mp = 20*log10(max(mag)); % Convert magnitude to dB
    
    if abs(Mp - desired_Mp) < 0.1 % Check if within tolerance
        fprintf('Found K = %.2f for Mp = %.2f dB\n', K, Mp);
        break;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Deepseek

% Clear workspace and command window
clear;
clc;

% Step 1: Define the open-loop transfer function (OLTF)
s = tf('s');
GH = 1 / (s * (1 + s/200) * (1 + s/250)); % OLTF without K

% Step 2: Adjust K to achieve a resonant peak of 1.4 dB
K = 1; % Initial guess for K
tolerance = 0.01; % Tolerance for resonant peak
Mp_target = 1.4; % Target resonant peak in dB

while true
    % Define the OLTF with the current K
    GH_K = K * GH;

    % Plot the Nichols chart
    figure;
    nichols(GH_K);
    title(['Nichols Chart for K = ', num2str(K)]);
    grid on;

    % Get the Nichols plot data
    [mag, phase, w] = nichols(GH_K);
    mag_db = 20 * log10(squeeze(mag)); % Convert magnitude to dB

    % Find the resonant peak (maximum magnitude in dB)
    Mp = max(mag_db);

    % Check if the resonant peak is within the tolerance
    if abs(Mp - Mp_target) < tolerance
        break;
    end

    % Adjust K based on the difference between Mp and Mp_target
    if Mp < Mp_target
        K = K * 1.1; % Increase K
    else
        K = K * 0.9; % Decrease K
    end
end

% Step 3: Display the final value of K
fprintf('Final Value of K = %.4f\n', K);

% Step 4: Verify the resonant peak
[Gm, Pm, Wcg, Wcp] = margin(GH_K);
fprintf('Resonant Peak (Mp) = %.2f dB\n', max(mag_db));