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

